import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// Stands in for a tab whose feature isn't built yet.
class TabPlaceholder extends StatelessWidget {
  const TabPlaceholder({
    super.key,
    required this.title,
    required this.icon,
    this.action,
  });

  final String title;
  final String icon;

  /// Shown in the top corner, e.g. the language menu.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(icon, width: 48.w, height: 48.w),
                SizedBox(height: 16.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  AppLocalization.translateKey(context, 'coming_soon'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 15.sp),
                ),
              ],
            ),
          ),
          if (action != null)
            PositionedDirectional(top: 4.h, end: 8.w, child: action!),
        ],
      ),
    );
  }
}
