import 'package:discount_shop/features/member_validation/logic/member_validation_cubit.dart';
import 'package:discount_shop/features/member_validation/model/member_model.dart';
import 'package:discount_shop/features/member_validation/model/member_validation_repository.dart';
import 'package:discount_shop/features/member_validation/screen/member_validation_screen.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fails every load, to show the error state.
class _FailingRepository extends MemberValidationRepository {
  @override
  Future<MemberModel> getMember(String code) async => throw Exception('down');
}

Widget _app(MemberValidationCubit cubit, {Locale locale = const Locale('fr')}) {
  return BlocProvider.value(
    value: cubit,
    child: ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_, _) => MaterialApp(
        locale: locale,
        supportedLocales: AppLocalizationSetup.supportedLocales,
        localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
        home: const MemberValidationScreen(scanned: true),
      ),
    ),
  );
}

void main() {
  // rootBundle caches loaded files; a load cached by an earlier test never
  // completes in the next one, so the translations would never load.
  setUp(rootBundle.clear);

  setUp(() {
    final view =
        TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.physicalSize = const Size(430, 932);
    view.devicePixelRatio = 1;
  });

  group('MemberValidationCubit', () {
    test('loads the member and selects an offer', () async {
      final cubit = MemberValidationCubit(
        MemberValidationRepository(),
        code: '094281339901',
      );
      await cubit.load();

      final loaded = cubit.state as MemberValidationLoaded;
      expect(loaded.member.name, 'Soundous Bel');
      expect(loaded.member.initials, 'SB');
      expect(loaded.selectedOfferId, isNull);

      final offers = MemberValidationCubit.offersOf(loaded.member);
      expect(offers.last.id, MemberValidationCubit.noOffer.id);

      cubit.selectOffer(offers.first.id);
      expect(
        (cubit.state as MemberValidationLoaded).selectedOfferId,
        offers.first.id,
      );
    });

    test('a failed load shows the error', () async {
      final cubit = MemberValidationCubit(_FailingRepository(), code: '1');
      await cubit.load();
      expect(cubit.state, const MemberValidationState.error());
    });
  });

  testWidgets('shows the member, the offers and the points', (tester) async {
    addTearDown(tester.view.reset);
    final cubit = MemberValidationCubit(
      MemberValidationRepository(),
      code: '094281339901',
    )..load();
    await tester.pumpWidget(_app(cubit));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Validation du membre'), findsOneWidget);
    expect(find.text('Soundous Bel'), findsOneWidget);
    expect(find.text('Abonné(e)'), findsOneWidget);
    expect(find.text('Identité vérifiée via QR'), findsOneWidget);
    expect(find.text('10% de réduction'), findsOneWidget);
    expect(find.text('Café offert'), findsOneWidget);
    expect(find.textContaining('Pour l\'achat d\'une pâtisserie'), findsOne);
    expect(find.text('Aucune offre'), findsOneWidget);
    expect(find.textContaining('Solde de points :'), findsOneWidget);

    // The button only appears once an offer is picked.
    expect(find.text("VALIDER L'ACCÈS"), findsNothing);
    await tester.tap(find.text('Café offert'));
    await tester.pumpAndSettle();
    expect(find.text("VALIDER L'ACCÈS"), findsOneWidget);
  });

  testWidgets('shows the error with Retry', (tester) async {
    addTearDown(tester.view.reset);
    final cubit = MemberValidationCubit(_FailingRepository(), code: '1')
      ..load();
    await tester.pumpWidget(_app(cubit, locale: const Locale('ar')));
    await tester.pumpAndSettle();

    expect(find.text('تعذر تحميل بيانات العضو'), findsOneWidget);
    expect(find.text('إعادة المحاولة'), findsOneWidget);
  });
}
