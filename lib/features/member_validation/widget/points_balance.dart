import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../core/extensions/price.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// "Points balance: 1 250 pts" pill.
class PointsBalance extends StatelessWidget {
  const PointsBalance({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            color: AppColors.primary,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              '${t('points_balance')} ${points.asPrice} ${t('points_unit')}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
