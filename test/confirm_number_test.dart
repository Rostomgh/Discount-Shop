import 'package:discount_shop/features/confirm_number/screen/confirm_number_screen.dart';
import 'package:discount_shop/features/confirm_number/widget/otp_input.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget home) {
  return ScreenUtilInit(
    designSize: const Size(430, 932),
    builder: (_, _) => MaterialApp(
      locale: const Locale('fr'),
      supportedLocales: AppLocalizationSetup.supportedLocales,
      localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
      home: Scaffold(body: home),
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

  testWidgets('shows the translated texts and the phone number', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      _app(const ConfirmNumberScreen(phoneNumber: '+213 2 94 27 84 11')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Confirmer Numéro'), findsOneWidget);
    expect(find.text('Renvoyer'), findsOneWidget);
    expect(
      find.textContaining('+213 2 94 27 84 11', findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('typing 4 digits fills the boxes and reports the code',
      (tester) async {
    addTearDown(tester.view.reset);
    String? completed;
    await tester.pumpWidget(_app(OtpInput(onCompleted: (c) => completed = c)));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '12');
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(completed, isNull);

    await tester.enterText(find.byType(TextField), '1234');
    await tester.pump();
    expect(completed, '1234');
  });

  testWidgets('ignores letters', (tester) async {
    addTearDown(tester.view.reset);
    String? completed;
    await tester.pumpWidget(_app(OtpInput(onCompleted: (c) => completed = c)));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'a1b2c3d4');
    await tester.pump();
    expect(completed, '1234');
  });
}
