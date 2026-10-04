import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// "Recent transactions" and the red "Delete" button.
class TransactionsHeader extends StatelessWidget {
  const TransactionsHeader({super.key, this.onDelete});

  /// Null when there's nothing to delete; the button is then faded.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return Row(
      children: [
        Expanded(
          child: Text(
            t('recent_transactions'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        AnimatedOpacity(
          opacity: onDelete == null ? 0.35 : 1,
          duration: const Duration(milliseconds: 200),
          child: Semantics(
            button: true,
            enabled: onDelete != null,
            child: InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Text(
                  t('delete'),
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
