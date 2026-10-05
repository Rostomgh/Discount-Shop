import 'package:discount_shop/core/constant/enums.dart';
import 'package:discount_shop/features/discounts/logic/discounts_cubit.dart';
import 'package:discount_shop/features/discounts/model/discounts_repository.dart';
import 'package:discount_shop/features/login/screen/login_screen.dart';
import 'package:discount_shop/features/navigation/logic/navigation_cubit.dart';
import 'package:discount_shop/features/profile/logic/profile_cubit.dart';
import 'package:discount_shop/features/profile/model/profile_repository.dart';
import 'package:discount_shop/features/profile/screen/profile_screen.dart';
import 'package:discount_shop/features/profile/widget/logout_button.dart';
import 'package:discount_shop/logic/lang_cubit/lang_cubit.dart';
import 'package:discount_shop/shared/utils/app_router.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toastification/toastification.dart';

class _Cubits {
  final lang = LangCubit()..changeLang(const Locale('fr'));
  final profile = ProfileCubit(ProfileRepository());
  final discounts = DiscountsCubit(DiscountsRepository());
  final navigation = NavigationCubit()..selectTab(NavTab.profile);
}

Widget _app(_Cubits cubits) {
  return MultiBlocProvider(
    providers: [
      BlocProvider.value(value: cubits.lang),
      BlocProvider.value(value: cubits.profile),
      BlocProvider.value(value: cubits.discounts),
      BlocProvider.value(value: cubits.navigation),
    ],
    child: ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_, _) => ToastificationWrapper(
        child: BlocBuilder<LangCubit, LangState>(
          builder: (_, state) => MaterialApp(
            locale: state.locale,
            supportedLocales: AppLocalizationSetup.supportedLocales,
            localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
            onGenerateRoute: AppRouter().onGenerateRoute,
            home: const Scaffold(body: ProfileScreen()),
          ),
        ),
      ),
    ),
  );
}

/// Waits for the fake data (800 ms) and the entrance animations.
Future<void> _load(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

/// Lets the toasts close, so no timer is left when the test ends.
Future<void> _waitForToasts(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
}

void main() {
  // rootBundle caches loaded files; a load cached by an earlier test never
  // completes in the next one, so the translations would never load.
  setUp(rootBundle.clear);

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: 'Discount Shop',
      packageName: 'com.example.discount_shop',
      version: '2.4.1',
      buildNumber: '890',
      buildSignature: '',
    );
    final view =
        TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.physicalSize = const Size(430, 932);
    view.devicePixelRatio = 1;
  });

  group('ProfileCubit', () {
    test('loads the store and its branches', () async {
      final cubit = ProfileCubit(ProfileRepository());
      await cubit.load();

      final loaded = cubit.state as ProfileLoaded;
      expect(loaded.store.name, 'PC Store - SBA');
      expect(loaded.store.initials, 'PS');
      expect(loaded.branches, hasLength(3));
      expect(loaded.store.branchId, 'b1');
    });

    test('selectBranch, updateStore and reset', () async {
      final cubit = ProfileCubit(ProfileRepository());
      await cubit.load();

      cubit.selectBranch('b2');
      expect((cubit.state as ProfileLoaded).store.branchId, 'b2');

      final store = (cubit.state as ProfileLoaded).store;
      await cubit.updateStore(store.copyWith(name: 'PC Store - Oran'));
      final updated = (cubit.state as ProfileLoaded).store;
      expect(updated.name, 'PC Store - Oran');
      expect(updated.branchId, 'b2');

      cubit.reset();
      expect(cubit.state, const ProfileState.initial());
    });
  });

  group('DiscountsCubit', () {
    test(
      'add loads the discounts first, then puts the new one first',
      () async {
        final cubit = DiscountsCubit(DiscountsRepository());
        final repository = await DiscountsRepository().getDiscounts();
        await cubit.add(repository.first.copyWith());

        final discounts = (cubit.state as DiscountsLoaded).discounts;
        expect(discounts, hasLength(repository.length + 1));
      },
    );

    test('setActive and delete', () async {
      final cubit = DiscountsCubit(DiscountsRepository());
      await cubit.load();

      cubit.setActive('d1', false);
      var discounts = (cubit.state as DiscountsLoaded).discounts;
      expect(discounts.firstWhere((d) => d.id == 'd1').active, isFalse);

      cubit.delete('d1');
      discounts = (cubit.state as DiscountsLoaded).discounts;
      expect(discounts.any((d) => d.id == 'd1'), isFalse);
    });
  });

  testWidgets('shows the store, the sections and the version', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(_Cubits()));
    await _load(tester);

    expect(find.text('PC Store - SBA'), findsOneWidget);
    expect(find.text('pcstoresidibelabbes@example.com'), findsOneWidget);
    expect(find.text('Abonné(e)'), findsOneWidget);
    expect(find.text('COMPTE'), findsOneWidget);
    expect(find.text('Informations du magasin'), findsOneWidget);
    expect(find.text('Gérer les promotions'), findsOneWidget);
    expect(find.text('Clair'), findsOneWidget);

    await tester.scrollUntilVisible(find.byType(LogoutButton), 200);
    expect(find.textContaining('2.4.1'), findsOneWidget);
    expect(find.textContaining('890'), findsOneWidget);
  });

  testWidgets('the language switch changes the language', (tester) async {
    addTearDown(tester.view.reset);
    final cubits = _Cubits();
    await tester.pumpWidget(_app(cubits));
    await _load(tester);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(cubits.lang.state.locale, const Locale('en'));
    expect(find.text('Store Information'), findsOneWidget);
    expect(find.text('ACCOUNT'), findsOneWidget);
  });

  testWidgets('store information saves the new name', (tester) async {
    addTearDown(tester.view.reset);
    final cubits = _Cubits();
    await tester.pumpWidget(_app(cubits));
    await _load(tester);

    await tester.tap(find.text('Informations du magasin'));
    await tester.pumpAndSettle();

    // The Save button only appears once something changed.
    expect(find.text('ENREGISTRER'), findsNothing);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'PC Store - SBA'),
      'PC Store - Oran',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('ENREGISTRER'));
    await tester.pumpAndSettle();

    expect(
      (cubits.profile.state as ProfileLoaded).store.name,
      'PC Store - Oran',
    );
    expect(find.text('PC Store - Oran'), findsOneWidget);
    await _waitForToasts(tester);
  });

  testWidgets('change branch selects the tapped branch', (tester) async {
    addTearDown(tester.view.reset);
    final cubits = _Cubits();
    await tester.pumpWidget(_app(cubits));
    await _load(tester);

    await tester.tap(find.text("Changer d'agence"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Oran - Akid Lotfi'));
    await tester.pumpAndSettle();

    expect((cubits.profile.state as ProfileLoaded).store.branchId, 'b3');
    expect(find.byType(ProfileScreen), findsOneWidget);
    await _waitForToasts(tester);
  });

  testWidgets('manage discounts turns off and deletes a discount', (
    tester,
  ) async {
    addTearDown(tester.view.reset);
    final cubits = _Cubits();
    await tester.pumpWidget(_app(cubits));
    await _load(tester);

    await tester.tap(find.text('Gérer les promotions'));
    await _load(tester);
    expect(find.text('Rentrée scolaire'), findsOneWidget);
    expect(find.text('Black Friday'), findsOneWidget);

    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();
    var discounts = (cubits.discounts.state as DiscountsLoaded).discounts;
    expect(discounts.first.active, isFalse);

    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();
    expect(find.text('Supprimer cette promotion ?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Supprimer'));
    await tester.pumpAndSettle();

    discounts = (cubits.discounts.state as DiscountsLoaded).discounts;
    expect(discounts.any((d) => d.id == 'd1'), isFalse);
    expect(find.text('Rentrée scolaire'), findsNothing);
    await _waitForToasts(tester);
  });

  testWidgets('add discount checks the fields, then adds it', (tester) async {
    addTearDown(tester.view.reset);
    final cubits = _Cubits();
    await tester.pumpWidget(_app(cubits));
    await _load(tester);

    await tester.tap(find.text('Ajouter des promotions'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('ENREGISTRER LA PROMOTION'));
    await tester.pumpAndSettle();
    expect(find.text('Obligatoire'), findsOneWidget);
    expect(find.text('Choisissez une remise'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'Soldes');
    await tester.tap(find.textContaining('-20%'));
    await tester.tap(find.text('ENREGISTRER LA PROMOTION'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    final discounts = (cubits.discounts.state as DiscountsLoaded).discounts;
    expect(discounts.first.title, 'Soldes');
    expect(discounts.first.percent, 20);
    expect(find.byType(ProfileScreen), findsOneWidget);
    await _waitForToasts(tester);
  });

  testWidgets('log out asks first, then opens the login', (tester) async {
    addTearDown(tester.view.reset);
    final cubits = _Cubits();
    await tester.pumpWidget(_app(cubits));
    await _load(tester);

    await tester.scrollUntilVisible(find.byType(LogoutButton), 200);
    await tester.tap(find.byType(LogoutButton));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Déconnexion'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(cubits.profile.state, const ProfileState.initial());
    expect(cubits.navigation.state.tab, NavTab.home);
  });
}
