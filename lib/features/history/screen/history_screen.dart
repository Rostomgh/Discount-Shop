import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../logic/history_cubit.dart';
import '../widget/delete_history_dialog.dart';
import '../widget/history_title.dart';
import '../widget/transaction_list.dart';
import '../widget/transaction_search_bar.dart';
import '../widget/transactions_header.dart';

/// Second tab of the navigation bar: the partner's transactions.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<HistoryCubit>();
    if (cubit.state is HistoryInitial) cubit.loadTransactions();
  }

  Future<void> _deleteAll() async {
    final cubit = context.read<HistoryCubit>();
    if (await DeleteHistoryDialog.show(context)) cubit.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HistoryCubit>().state;
    final canDelete = state is HistoryLoaded && state.transactions.isNotEmpty;

    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.h),
            const HistoryTitle(),
            SizedBox(height: 22.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const TransactionSearchBar(),
            ),
            SizedBox(height: 22.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: TransactionsHeader(
                onDelete: canDelete ? _deleteAll : null,
              ),
            ),
            SizedBox(height: 12.h),
            const Expanded(child: TransactionList()),
          ],
        ),
      ),
    );
  }
}
