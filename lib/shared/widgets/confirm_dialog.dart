import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/theme/colors.dart';
import '../utils/localization/app_ localization.dart';

/// A question with Cancel and a red confirm button, e.g. "Log out?".
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmText,
  });

  final IconData icon;
  final String title;
  final String message;
  final String confirmText;

  /// True if the user confirmed.
  static Future<bool> show(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    required String confirmText,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        icon: icon,
        title: title,
        message: message,
        confirmText: confirmText,
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
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
        child: Icon(icon, color: AppColors.error, size: 28.w),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 19.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        message,
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
                child: Text(AppLocalization.translateKey(context, 'cancel')),
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
                child: Text(confirmText),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
