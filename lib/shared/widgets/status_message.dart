import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/theme/colors.dart';

/// Centered icon and text for an empty list or a loading error.
class StatusMessage extends StatelessWidget {
  const StatusMessage({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  /// E.g. a "Retry" button.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.h),
      child: Column(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: const BoxDecoration(
              color: AppColors.chipBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 32.w),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 6.h),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          ],
          if (action != null) ...[SizedBox(height: 12.h), action!],
        ],
      ),
    );
  }
}
