import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/theme/colors.dart';
import 'fade_slide_in.dart';

/// Back button, a blue title and the line under it, at the top of a page.
class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // Centered even when the texts are shorter than the screen.
      alignment: Alignment.topCenter,
      children: [
        FadeSlideIn(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Column(
              children: [
                SizedBox(height: 14.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 10.h),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16.sp,
                      height: 1.45,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        PositionedDirectional(
          start: 4.w,
          top: 0,
          child: IconButton(
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () => Navigator.maybePop(context),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textPrimary,
              size: 24.w,
            ),
          ),
        ),
      ],
    );
  }
}
