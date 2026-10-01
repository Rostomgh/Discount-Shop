import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';

/// One square of the code input; shows a single digit.
class OtpBox extends StatelessWidget {
  const OtpBox({super.key, this.digit, this.isActive = false});

  final String? digit;

  /// True for the box the next digit will go into.
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final highlighted = isActive || digit != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 74.w,
      height: 74.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: highlighted ? AppColors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.boxBorder,
          width: isActive ? 1.5 : 1,
        ),
      ),
      child: Text(
        digit ?? '',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
