import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/camera_circle_button.dart';

/// Close button, "QUICK ADD" title and flash button over the camera.
class CameraTopBar extends StatelessWidget {
  const CameraTopBar({
    super.key,
    required this.flashOn,
    this.showFlash = true,
    this.onClose,
    this.onFlash,
  });

  final bool flashOn;

  /// False once there's a photo: the flash is no use then.
  final bool showFlash;
  final VoidCallback? onClose;
  final VoidCallback? onFlash;

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return Row(
      children: [
        CameraCircleButton(
          icon: Icons.close,
          label: t('close'),
          onPressed: onClose,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                t('quick_add'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        AnimatedOpacity(
          opacity: showFlash ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: IgnorePointer(
            ignoring: !showFlash,
            child: CameraCircleButton(
              icon: flashOn ? Icons.flash_on : Icons.flash_off,
              label: t('flash'),
              onPressed: onFlash,
            ),
          ),
        ),
      ],
    );
  }
}
