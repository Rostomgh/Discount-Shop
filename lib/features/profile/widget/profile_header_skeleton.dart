import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/widgets/pulsing.dart';

/// Gray pulsing photo and lines shown while the store loads.
class ProfileHeaderSkeleton extends StatelessWidget {
  const ProfileHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget bar(double width, double height) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );

    return Pulsing(
      child: Column(
        children: [
          Container(
            width: 124.w,
            height: 124.w,
            decoration: const BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 28.h),
          bar(190.w, 26.h),
          SizedBox(height: 12.h),
          bar(230.w, 14.h),
        ],
      ),
    );
  }
}
