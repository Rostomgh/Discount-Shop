import 'package:discount_shop/features/scanner/logic/scanner_cubit.dart';
import 'package:discount_shop/features/scanner/screen/scanner_screen.dart';
import 'package:discount_shop/shared/utils/app_router.dart';
import 'package:discount_shop/shared/utils/dep_inj.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

Widget _app(ScannerCubit cubit) {
  return BlocProvider.value(
    value: cubit,
    child: ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_, _) => ToastificationWrapper(
        child: MaterialApp(
          locale: const Locale('fr'),
          supportedLocales: AppLocalizationSetup.supportedLocales,
          localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
          onGenerateRoute: AppRouter().onGenerateRoute,
          home: const Scaffold(body: ScannerScreen(active: true)),
        ),
      ),
    ),
  );
}

// The camera spinner never stops in tests (there is no scanner plugin), so
// pumpAndSettle would time out.
Future<void> _settle(WidgetTester tester, {int steps = 10}) async {
  for (var i = 0; i < steps; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUpAll(DepInj.setup);

  // rootBundle caches loaded files; a load cached by an earlier test never
  // completes in the next one, so the translations would never load.
  setUp(rootBundle.clear);

  setUp(() {
    final view =
        TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.physicalSize = const Size(430, 932);
    view.devicePixelRatio = 1;
  });

  group('ScannerCubit', () {
    test('a found card is kept until scanAgain', () {
      final cubit = ScannerCubit()..cardFound(' 094281339901 ');
      expect(cubit.state, const ScannerState.found(code: '094281339901'));
      expect((cubit.state as ScannerFound).scanned, isTrue);

      // The camera keeps sending codes while the card is shown.
      cubit.cardFound('111122223333');
      expect(cubit.state, const ScannerState.found(code: '094281339901'));

      cubit.scanAgain();
      expect(cubit.state, const ScannerState.scanning());
    });

    test('ignores empty codes', () {
      final cubit = ScannerCubit()..cardFound('  ');
      expect(cubit.state, const ScannerState.scanning());
    });

    test('formatCode groups digits by 4', () {
      expect(ScannerCubit.formatCode('094281339901'), '0942 8133 9901');
      expect(ScannerCubit.formatCode('12345'), '1234 5');
      expect(ScannerCubit.formatCode('https://a.b'), 'https://a.b');
    });
  });

  testWidgets('shows the title and the manual entry button', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(ScannerCubit()));
    await _settle(tester);

    expect(find.text('Scanner une carte'), findsOneWidget);
    expect(find.text('SAISIE MANUELLE'), findsOneWidget);
  });

  testWidgets('manual entry needs the 12 digits', (tester) async {
    addTearDown(tester.view.reset);
    final cubit = ScannerCubit();
    await tester.pumpWidget(_app(cubit));
    await _settle(tester);

    await tester.tap(find.text('SAISIE MANUELLE'));
    await _settle(tester);
    expect(find.text('Saisir le numéro de carte'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '0942');
    await tester.tap(find.text('VALIDER'));
    await _settle(tester);
    expect(find.text('Saisissez les 12 chiffres de la carte'), findsOneWidget);
    expect(cubit.state, const ScannerState.scanning());
  });

  testWidgets('a typed card opens the member, then scanning goes on', (
    tester,
  ) async {
    addTearDown(tester.view.reset);
    final cubit = ScannerCubit();
    await tester.pumpWidget(_app(cubit));
    await _settle(tester);

    await tester.tap(find.text('SAISIE MANUELLE'));
    await _settle(tester);
    await tester.enterText(find.byType(TextFormField), '094281339901');
    await tester.pump();
    // Grouped like on the card while typing.
    expect(find.text('0942 8133 9901'), findsOneWidget);

    await tester.tap(find.text('VALIDER'));
    // The green frame, the page transition, then the (fake) member loads.
    await _settle(tester, steps: 25);

    expect(
      cubit.state,
      const ScannerState.found(code: '094281339901', scanned: false),
    );
    expect(find.text('Validation du membre'), findsOneWidget);
    expect(find.text('Soundous Bel'), findsOneWidget);
    expect(find.text('Numéro saisi manuellement'), findsOneWidget);

    await tester.tap(find.text('Aucune offre'));
    await _settle(tester);
    await tester.tap(find.text("VALIDER L'ACCÈS"));
    await _settle(tester);

    expect(find.text('Validation du membre'), findsNothing);
    expect(find.text('Accès validé'), findsOneWidget);
    expect(cubit.state, const ScannerState.scanning());
    // Lets the toast close.
    await _settle(tester, steps: 40);
  });
}
