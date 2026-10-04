import 'package:discount_shop/core/constant/routes.dart';
import 'package:discount_shop/features/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app() {
  return ScreenUtilInit(
    designSize: const Size(430, 932),
    builder: (_, _) => MaterialApp(
      routes: {
        Routes.splash: (_) => const SplashScreen(),
        Routes.login: (_) => const Scaffold(body: Text('login')),
      },
    ),
  );
}

void main() {
  setUp(rootBundle.clear);

  testWidgets('goes to the login screen after the splash duration',
      (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_app());

    await tester.pump(SplashScreen.duration - const Duration(milliseconds: 100));
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('login'), findsNothing);

    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();
    expect(find.byType(SplashScreen), findsNothing);
    expect(find.text('login'), findsOneWidget);
  });
}
