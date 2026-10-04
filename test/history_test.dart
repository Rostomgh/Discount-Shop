import 'package:discount_shop/core/constant/enums.dart';
import 'package:discount_shop/core/extensions/price.dart';
import 'package:discount_shop/features/history/logic/history_cubit.dart';
import 'package:discount_shop/features/history/model/history_repository.dart';
import 'package:discount_shop/features/history/model/transaction_model.dart';
import 'package:discount_shop/features/history/screen/history_screen.dart';
import 'package:discount_shop/features/history/widget/transaction_card.dart';
import 'package:discount_shop/shared/utils/localization/app_ localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(HistoryCubit cubit) {
  return BlocProvider.value(
    value: cubit,
    child: ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_, _) => const MaterialApp(
        locale: Locale('fr'),
        supportedLocales: AppLocalizationSetup.supportedLocales,
        localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
        home: Scaffold(body: HistoryScreen()),
      ),
    ),
  );
}

Future<HistoryCubit> _loadedCubit() async {
  final cubit = HistoryCubit(HistoryRepository());
  await cubit.loadTransactions();
  return cubit;
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

  group('HistoryCubit', () {
    test('loads the fake transactions, newest first', () async {
      final cubit = await _loadedCubit();
      final transactions = (cubit.state as HistoryLoaded).transactions;

      expect(transactions, isNotEmpty);
      for (var i = 1; i < transactions.length; i++) {
        expect(transactions[i].date.isAfter(transactions[i - 1].date), isFalse);
      }
    });

    test('delete returns the position and restore puts it back', () async {
      final cubit = await _loadedCubit();
      final before = (cubit.state as HistoryLoaded).transactions;
      final second = before[1];

      final index = cubit.delete(second.id);
      expect(index, 1);
      expect(
        (cubit.state as HistoryLoaded).transactions,
        isNot(contains(second)),
      );

      cubit.restore(second, index);
      expect((cubit.state as HistoryLoaded).transactions, before);
    });

    test('deleteAll empties the list', () async {
      final cubit = await _loadedCubit();
      cubit.deleteAll();
      expect((cubit.state as HistoryLoaded).transactions, isEmpty);
    });
  });

  test('matches searches the description and the type', () {
    final tx = TransactionModel(
      id: 'x',
      type: TransactionType.refund,
      description: 'Remboursement #42',
      amount: 100,
      date: DateTime(2026),
    );
    expect(tx.matches('#42', typeLabel: 'Remboursement'), isTrue);
    expect(tx.matches('REMB', typeLabel: 'Remboursement'), isTrue);
    expect(tx.matches('achat', typeLabel: 'Remboursement'), isFalse);
    expect(tx.matches('', typeLabel: 'Remboursement'), isTrue);
  });

  test('asSignedPrice shows the sign', () {
    String plain(String s) => s
        .replaceAll(String.fromCharCode(0x2066), '')
        .replaceAll(String.fromCharCode(0x2069), '')
        .replaceAll(String.fromCharCode(0xA0), ' ');
    expect(plain(450.asSignedPrice), '+450');
    expect(plain((-18500).asSignedPrice), '-18 500');
  });

  testWidgets('shows the translated screen and the transactions', (
    tester,
  ) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(HistoryCubit(HistoryRepository())));
    await tester.pumpAndSettle();

    expect(find.text('Historique des transactions'), findsOneWidget);
    expect(find.text('Cashback de la commande #2106'), findsOneWidget);
    expect(find.text("Aujourd'hui"), findsWidgets);
    expect(find.text('Récompense'), findsWidgets);
  });

  testWidgets('searching filters the list', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(HistoryCubit(HistoryRepository())));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'nike');
    await tester.pumpAndSettle();

    expect(find.byType(TransactionCard), findsOneWidget);
    expect(find.text('Commande (Nike Air Max 270)'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.pumpAndSettle();
    expect(
      find.text('Aucune transaction ne correspond à votre recherche'),
      findsOneWidget,
    );
  });

  testWidgets('swiping deletes a card and Undo brings it back', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(HistoryCubit(HistoryRepository())));
    await tester.pumpAndSettle();

    const text = 'Cashback de la commande #2106';
    await tester.drag(find.text(text), const Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text(text), findsNothing);
    expect(find.text('Transaction supprimée'), findsOneWidget);

    await tester.tap(find.text('Annuler'));
    await tester.pumpAndSettle();
    expect(find.text(text), findsOneWidget);
  });

  testWidgets('Delete asks first, then empties the history', (tester) async {
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(HistoryCubit(HistoryRepository())));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Supprimer'));
    await tester.pumpAndSettle();
    expect(find.text("Supprimer l'historique ?"), findsOneWidget);

    // The dialog's red button.
    await tester.tap(find.widgetWithText(FilledButton, 'Supprimer'));
    await tester.pumpAndSettle();

    expect(find.byType(TransactionCard), findsNothing);
    expect(find.text('Aucune transaction'), findsOneWidget);
  });
}
