import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/widgets/pulsing.dart';

/// Gray pulsing cards shown while the discounts load.
class DiscountListSkeleton extends StatelessWidget {
  const DiscountListSkeleton({super.key, this.count = 3});

  final int count;

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
          for (var i = 0; i < count; i++)
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bar(140.w, 14.h),
                        SizedBox(height: 10.h),
                        bar(180.w, 10.h),
                        SizedBox(height: 10.h),
                        bar(90.w, 10.h),
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
