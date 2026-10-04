import 'package:discount_shop/core/constant/enums.dart';
import 'package:discount_shop/features/history/logic/history_cubit.dart';
import 'package:discount_shop/features/history/model/history_repository.dart';
import 'package:discount_shop/features/home/logic/home_cubit.dart';
import 'package:discount_shop/features/home/model/home_repository.dart';
import 'package:discount_shop/features/home/screen/home_screen.dart';
import 'package:discount_shop/features/home/widget/category_chip.dart';
import 'package:discount_shop/features/navigation/logic/navigation_cubit.dart';
import 'package:discount_shop/features/navigation/screen/navigation_screen.dart';
import 'package:discount_shop/features/navigation/widget/nav_bar_item.dart';
import 'package:discount_shop/logic/lang_cubit/lang_cubit.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(NavigationCubit cubit) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => LangCubit()),
      BlocProvider(create: (_) => HomeCubit(HomeRepository())),
      BlocProvider(create: (_) => HistoryCubit(HistoryRepository())),
      BlocProvider.value(value: cubit),
    ],
    child: ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_, _) => const MaterialApp(
        locale: Locale('fr'),
        supportedLocales: AppLocalizationSetup.supportedLocales,
        localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
        home: NavigationScreen(),
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

  group('NavigationCubit', () {
    test('starts on the home tab', () {
      expect(NavigationCubit().state.tab, NavTab.home);
    });

    test('selectTab emits the new tab', () {
      final cubit = NavigationCubit()..selectTab(NavTab.profile);
      expect(cubit.state.tab, NavTab.profile);
    });
  });

  testWidgets('opens on the home tab with the discounted products', (
    tester,
  ) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(NavigationCubit()));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Mes promotions'), findsOneWidget);
    expect(find.text('Pull en maille vert'), findsOneWidget);
    expect(find.text('Ajouter un produit'), findsOneWidget);

    final items = tester.widgetList<NavBarItem>(find.byType(NavBarItem));
    expect(items.map((i) => i.selected), [true, false, false, false]);
  });

  testWidgets('a category chip filters the products', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(NavigationCubit()));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(CategoryChip, 'Accessoires'));
    await tester.pumpAndSettle();

    expect(find.text('Tote bag Farmers Market'), findsOneWidget);
    expect(find.text('Pull en maille vert'), findsNothing);
  });

  testWidgets('tapping a nav bar icon switches the tab', (tester) async {
    addTearDown(tester.view.reset);
    final cubit = NavigationCubit();
    await tester.pumpWidget(_app(cubit));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(NavBarItem).at(1));
    await tester.pumpAndSettle();

    expect(cubit.state.tab, NavTab.history);
    expect(find.text('Historique des transactions'), findsOneWidget);
    expect(find.text('Mes promotions'), findsNothing);

    await tester.tap(find.byType(NavBarItem).first);
    await tester.pumpAndSettle();
    expect(find.text('Mes promotions'), findsOneWidget);
  });

  testWidgets('the add button opens the camera or gallery choice', (
    tester,
  ) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(NavigationCubit()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ajouter un produit'));
    await tester.pumpAndSettle();

    expect(find.text('Prendre une photo'), findsOneWidget);
    expect(find.text('Importer depuis la galerie'), findsOneWidget);
  });

  // Android can draw the first frame before the screen has a size, which
  // makes every ScreenUtil value 0. The painters must survive that.
  testWidgets('survives a first frame with a zero-size screen', (tester) async {
    tester.view.physicalSize = Size.zero;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_app(NavigationCubit()));
    await tester.pumpAndSettle();

    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
