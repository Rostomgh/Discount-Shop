import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/status_message.dart';
import '../logic/history_cubit.dart';
import '../model/transaction_model.dart';
import 'transaction_card.dart';
import 'transaction_list_skeleton.dart';

/// The transactions matching the search, or the loading, empty and error
/// states. Swiping a card deletes it, with "Undo".
class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  void _delete(BuildContext context, TransactionModel transaction) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final cubit = context.read<HistoryCubit>();
    final index = cubit.delete(transaction.id);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(t('transaction_deleted')),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.textPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          // Goes away by itself even though it has an action.
          persist: false,
          action: SnackBarAction(
            label: t('undo'),
            textColor: AppColors.chipBackground,
            onPressed: () => cubit.restore(transaction, index),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final state = context.watch<HistoryCubit>().state;

    final Widget child = switch (state) {
      HistoryInitial() || HistoryLoading() => const TransactionListSkeleton(
        key: ValueKey('loading'),
      ),
      HistoryError() => StatusMessage(
        key: const ValueKey('error'),
        icon: Icons.cloud_off_outlined,
        title: t('history_load_error'),
        action: TextButton(
          onPressed: context.read<HistoryCubit>().loadTransactions,
          child: Text(t('retry')),
        ),
      ),
      HistoryLoaded(:final transactions) when transactions.isEmpty =>
        StatusMessage(
          key: const ValueKey('empty'),
          icon: Icons.receipt_long_outlined,
          title: t('no_transactions'),
          subtitle: t('no_transactions_hint'),
        ),
      HistoryLoaded(:final transactions, :final query) => () {
        final shown = transactions
            .where(
              (tx) => tx.matches(
                query,
                typeLabel: t(TransactionCard.typeKey(tx.type)),
              ),
            )
            .toList();
        if (shown.isEmpty) {
          return StatusMessage(
            key: const ValueKey('no-results'),
            icon: Icons.search_off,
            title: t('no_search_results'),
          );
        }
        return ListView.builder(
          key: const ValueKey('list'),
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: shown.length,
          // Keeps each card's state when one above it is removed, so the
          // others don't play their entrance animation again.
          findChildIndexCallback: (key) {
            final index = shown.indexWhere((tx) => key == ValueKey(tx.id));
            return index < 0 ? null : index;
          },
          itemBuilder: (context, i) {
            final transaction = shown[i];
            return Padding(
              key: ValueKey(transaction.id),
              padding: EdgeInsets.only(bottom: 12.h),
              child: Dismissible(
                key: ValueKey('dismiss-${transaction.id}'),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => _delete(context, transaction),
                background: const _DeleteBackground(),
                child: FadeSlideIn(
                  delay: Duration(milliseconds: 70 * min(i, 6)),
                  child: TransactionCard(transaction: transaction),
                ),
              ),
            );
          },
        );
      }(),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      layoutBuilder: (current, previous) => Stack(
        alignment: Alignment.topCenter,
        children: [...previous, if (current != null) current],
      ),
      child: child,
    );
  }
}

/// Red area with a bin, revealed while swiping a card away.
class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      padding: EdgeInsetsDirectional.only(end: 24.w),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(Icons.delete_outline, color: AppColors.white, size: 26.w),
    );
  }
}
