import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/widgets/pulsing.dart';

/// Gray pulsing cards shown while the transactions load.
class TransactionListSkeleton extends StatelessWidget {
  const TransactionListSkeleton({super.key, this.count = 5});

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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            for (var i = 0; i < count; i++)
              Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [bar(70.w, 10.h), bar(44.w, 10.h)],
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [bar(170.w, 14.h), bar(70.w, 14.h)],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
