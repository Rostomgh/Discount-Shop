import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import 'add_option_tile.dart';

/// Bottom sheet: take a photo or import one. Pops with the [ImageSource].
class AddProductOptions extends StatelessWidget {
  const AddProductOptions({super.key});

  static Future<ImageSource?> show(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddProductOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 52.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.boxBorder,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                t('add_a_product'),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                t('add_product_question'),
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 20.h),
              FadeSlideIn(
                child: AddOptionTile(
                  icon: Icons.photo_camera_outlined,
                  title: t('take_photo'),
                  subtitle: t('take_photo_hint'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
              ),
              SizedBox(height: 12.h),
              FadeSlideIn(
                delay: const Duration(milliseconds: 80),
                child: AddOptionTile(
                  icon: Icons.photo_library_outlined,
                  title: t('import_gallery'),
                  subtitle: t('import_gallery_hint'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
