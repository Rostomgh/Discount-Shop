import 'package:discount_shop/features/add_product/logic/add_product_cubit.dart';
import 'package:discount_shop/features/add_product/screen/add_product_screen.dart';
import 'package:discount_shop/features/home/model/product_model.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// A page with a button that opens the add product screen and keeps what it
/// returns in [result].
class _Opener extends StatefulWidget {
  const _Opener();

  @override
  State<_Opener> createState() => _OpenerState();
}

ProductModel? result;

class _OpenerState extends State<_Opener> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () async {
          result = await Navigator.push<ProductModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => AddProductCubit(),
                child: const AddProductScreen(),
              ),
            ),
          );
        },
        child: const Text('open'),
      ),
    );
  }
}

Widget _app() {
  return ScreenUtilInit(
    designSize: const Size(430, 932),
    builder: (_, _) => const MaterialApp(
      locale: Locale('fr'),
      supportedLocales: AppLocalizationSetup.supportedLocales,
      localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
      home: _Opener(),
    ),
  );
}

void main() {
  // rootBundle caches loaded files; a load cached by an earlier test never
  // completes in the next one, so the translations would never load.
  setUp(rootBundle.clear);

  // The device has no camera.
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/camera'),
          (_) async => <Object>[],
        );
  });

  setUp(() {
    result = null;
    final view =
        TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.physicalSize = const Size(430, 932);
    view.devicePixelRatio = 1;
  });

  Future<void> open(WidgetTester tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('without a camera it suggests the gallery', (tester) async {
    await open(tester);

    expect(find.text('AJOUT RAPIDE'), findsOneWidget);
    expect(find.textContaining("n'est pas disponible"), findsOneWidget);
  });

  testWidgets('shows what is missing', (tester) async {
    await open(tester);

    await tester.tap(find.text('AJOUTER LE PRODUIT'));
    await tester.pumpAndSettle();

    expect(find.text('Obligatoire'), findsOneWidget);
    expect(find.text('Entrez un prix'), findsOneWidget);
    expect(find.text('Choisissez une remise'), findsOneWidget);
    expect(result, isNull);
  });

  testWidgets('returns the new product', (tester) async {
    await open(tester);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Écharpe en laine');
    await tester.enterText(fields.at(1), 'Accessoires');
    await tester.enterText(fields.at(2), '2500');
    await tester.ensureVisible(find.textContaining('30%'));
    await tester.tap(find.textContaining('30%'));
    await tester.ensureVisible(find.text('Nouveauté'));
    await tester.tap(find.text('Nouveauté'));
    await tester.pump();

    await tester.tap(find.text('AJOUTER LE PRODUIT'));
    await tester.pumpAndSettle();

    expect(result, isNotNull);
    expect(result!.name, 'Écharpe en laine');
    expect(result!.category, 'Accessoires');
    expect(result!.price, 2500);
    expect(result!.discount, 30);
    expect(result!.tags, ['tag_new']);
    expect(find.byType(AddProductScreen), findsNothing);
  });
}
