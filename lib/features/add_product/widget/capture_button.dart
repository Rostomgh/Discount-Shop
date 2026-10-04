import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// White round "take a photo" button inside a white ring.
class CaptureButton extends StatelessWidget {
  const CaptureButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: AppLocalization.translateKey(context, 'take_photo'),
      child: Container(
        width: 70.w,
        height: 70.w,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2.5),
        ),
        child: Material(
          color: AppColors.white,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 26.w,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
