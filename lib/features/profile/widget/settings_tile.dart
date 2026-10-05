import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';

/// One row of the profile: icon, title, and a value, a [trailing] widget or
/// a chevron. Faded while [onTap] is null.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.trailing,
    this.showChevron = true,
    this.onTap,
  });

  final IconData icon;
  final String title;

  /// Gray text at the end, e.g. "Light".
  final String? value;

  /// E.g. the language switch.
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null || trailing != null;

    return AnimatedOpacity(
      opacity: enabled ? 1 : 0.5,
      duration: const Duration(milliseconds: 250),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 15.h),
            child: Row(
              children: [
                Icon(icon, color: AppColors.textSecondary, size: 24.w),
                SizedBox(width: 18.w),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
                if (value != null)
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.w),
                      child: Text(
                        value!,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                if (trailing != null) ...[SizedBox(width: 8.w), trailing!],
                if (showChevron) ...[
                  SizedBox(width: 8.w),
                  // Mirrored in Arabic.
                  Icon(Icons.chevron_right, color: AppColors.icon, size: 24.w),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
