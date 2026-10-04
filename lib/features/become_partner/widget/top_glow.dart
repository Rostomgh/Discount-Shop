import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';

/// Soft blue light in the top right corner of the screen.
class TopGlow extends StatelessWidget {
  const TopGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -150.w,
      right: -120.w,
      child: IgnorePointer(
        child: Container(
          width: 340.w,
          height: 340.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.07),
                AppColors.primary.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
