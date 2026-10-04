import 'package:discount_shop/core/constant/routes.dart';
import 'package:discount_shop/features/become_partner/screen/become_partner_screen.dart';
import 'package:discount_shop/shared/utils/app_router.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(String initialRoute) {
  final router = AppRouter();
  return ScreenUtilInit(
    designSize: const Size(430, 932),
    builder: (_, _) => MaterialApp(
      locale: const Locale('fr'),
      supportedLocales: AppLocalizationSetup.supportedLocales,
      localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
      initialRoute: initialRoute,
      onGenerateRoute: router.onGenerateRoute,
    ),
  );
}

void main() {
  // rootBundle caches loaded files; a load cached by an earlier test never
  // completes in the next one, so the translations would never load.
  setUp(rootBundle.clear);

  setUp(() {
    final view = TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.physicalSize = const Size(430, 932);
    view.devicePixelRatio = 1;
  });

  testWidgets('shows the translated form', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(Routes.becomePartner));
    await tester.pumpAndSettle();

    expect(find.text('Devenir Partenaire'), findsOneWidget);
    expect(find.text("Nom de l'entreprise *"), findsOneWidget);
    // The only optional field has no asterisk.
    expect(find.text('Nombre de succursales'), findsOneWidget);
    expect(find.text('Numéro de téléphone *'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(6));
    expect(find.text('ENVOYER MA DEMANDE'), findsOneWidget);
    expect(find.text('Conditions Générales'), findsOneWidget);
  });

  testWidgets('the login screen opens it', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(Routes.login));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Devenir Partenaire'));
    await tester.tap(find.text('Devenir Partenaire'));
    await tester.pumpAndSettle();

    expect(find.byType(BecomePartnerScreen), findsOneWidget);
  });
}
