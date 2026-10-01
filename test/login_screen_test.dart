import 'package:discount_shop/features/login/screen/login_screen.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app() {
  return ScreenUtilInit(
    designSize: const Size(430, 932),
    builder: (_, _) => const MaterialApp(
      locale: Locale('fr'),
      supportedLocales: AppLocalizationSetup.supportedLocales,
      localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
      home: LoginScreen(),
    ),
  );
}

void main() {
  // rootBundle caches loaded files; a load cached by an earlier test never
  // completes in the next one, so the translations would never load.
  setUp(rootBundle.clear);

  testWidgets('shows the translated login texts', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Continuer avec Google'), findsOneWidget);
    expect(find.text('Activer mon compte'), findsOneWidget);
  });

  // Android can draw the first frame before the screen has a size, which
  // makes every ScreenUtil value 0. The login screen must survive that.
  testWidgets('survives a first frame with a zero-size screen', (tester) async {
    tester.view.physicalSize = Size.zero;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
