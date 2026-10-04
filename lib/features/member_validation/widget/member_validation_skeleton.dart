import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/widgets/pulsing.dart';

/// Gray pulsing photo, name and offers shown while the member loads.
class MemberValidationSkeleton extends StatelessWidget {
  const MemberValidationSkeleton({super.key});

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
          SizedBox(height: 10.h),
          bar(150.w, 14.h),
          SizedBox(height: 30.h),
          for (var i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.only(bottom: 14.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  bar(26.w, 26.w),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bar(140.w, 16.h),
                        SizedBox(height: 8.h),
                        bar(210.w, 12.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
