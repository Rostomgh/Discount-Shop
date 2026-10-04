import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// "Delete the history?" with Cancel and Delete.
class DeleteHistoryDialog extends StatelessWidget {
  const DeleteHistoryDialog({super.key});

  /// True if the partner confirmed.
  static Future<bool> show(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteHistoryDialog(),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13.r),
    );

    return AlertDialog(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
      icon: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.delete_outline, color: AppColors.error, size: 28.w),
      ),
      title: Text(
        t('delete_all_title'),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 19.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        t('delete_all_message'),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 15.sp,
          height: 1.4,
        ),
      ),
      actionsPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.border),
                  shape: buttonShape,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Text(t('cancel')),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: AppColors.white,
                  shape: buttonShape,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                onPressed: () => Navigator.pop(context, true),
                child: Text(t('delete')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
