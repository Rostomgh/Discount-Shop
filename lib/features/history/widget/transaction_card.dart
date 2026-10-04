import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/enums.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../core/extensions/price.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../model/transaction_model.dart';

/// One transaction: type and date on top, description and amount below.
/// Money in is blue, money out is red.
class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});

  final TransactionModel transaction;

  static String typeKey(TransactionType type) => switch (type) {
    TransactionType.reward => 'tx_reward',
    TransactionType.purchase => 'tx_purchase',
    TransactionType.refund => 'tx_refund',
    TransactionType.topUp => 'tx_top_up',
  };

  /// "Today", "Yesterday", or a short date like "May 11" / "11 mai".
  static String dateLabel(BuildContext context, DateTime date) {
    final days = DateUtils.dateOnly(
      DateTime.now(),
    ).difference(DateUtils.dateOnly(date)).inDays;
    if (days == 0) return AppLocalization.translateKey(context, 'today');
    if (days == 1) return AppLocalization.translateKey(context, 'yesterday');
    final locale = Localizations.localeOf(context).languageCode;
    // Same digits as the rest of the app, also in Arabic.
    return (DateFormat.MMMd(locale)..useNativeDigits = false).format(date);
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final amountColor = transaction.isCredit
        ? AppColors.primary
        : AppColors.error;

    return Container(
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t(typeKey(transaction.type)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                dateLabel(context, transaction.date),
                style: TextStyle(color: AppColors.textMuted, fontSize: 13.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  transaction.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '${transaction.amount.asSignedPrice} ${t('currency')}',
                style: TextStyle(
                  color: amountColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
