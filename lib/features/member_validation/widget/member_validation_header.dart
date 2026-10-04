import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';

/// Back button, "Member validation" and the line under it.
class MemberValidationHeader extends StatelessWidget {
  const MemberValidationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

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
                  t('member_validation_title'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  t('member_validation_subtitle'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                    height: 1.45,
                  ),
                ),
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
