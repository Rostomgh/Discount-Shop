import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/images.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Both sizes are set so the layout doesn't jump while the SVG loads.
        SvgPicture.asset(AppImages.logoBlue, width: 106.w, height: 110.w),
        SizedBox(height: 12.h),
        Text(
          AppLocalization.translateKey(context, 'login_title'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 38.sp,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          AppLocalization.translateKey(context, 'login_subtitle'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 17.sp,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
