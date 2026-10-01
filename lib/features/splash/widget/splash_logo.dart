import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/images.dart';
import '../../../core/constant/theme/colors.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImages.logo, width: 125.w),
        SizedBox(height: 22.h),
        Text(
          'DISCOUNT',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
