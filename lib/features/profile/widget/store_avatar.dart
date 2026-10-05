import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../model/store_model.dart';

/// Round store photo with a white ring; the initials when there is no photo.
/// With [onEdit], a small camera button sits on its edge.
class StoreAvatar extends StatelessWidget {
  const StoreAvatar({
    super.key,
    required this.store,
    required this.size,
    this.photoPath,
    this.onEdit,
  });

  final StoreModel store;
  final double size;

  /// Shown instead of the store's photo, e.g. one just picked.
  final String? photoPath;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final initials = Center(
      child: Text(
        store.initials,
        style: TextStyle(
          color: AppColors.white,
          fontSize: size * 0.34,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
    final photo = photoPath ?? store.photoPath;

    final avatar = Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
          ),
          // Fades between the initials and a new photo.
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: photo == null
                ? initials
                : Image.file(
                    File(photo),
                    key: ValueKey(photo),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (_, _, _) => initials,
                  ),
          ),
        ),
      ),
    );

    if (onEdit == null) return avatar;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        PositionedDirectional(
          end: 0,
          bottom: 4.h,
          child: Semantics(
            button: true,
            label: AppLocalization.translateKey(context, 'change_photo'),
            child: Material(
              color: AppColors.primary,
              shape: const CircleBorder(
                side: BorderSide(color: AppColors.white, width: 3),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onEdit,
                child: SizedBox.square(
                  dimension: 38.w,
                  child: Icon(
                    Icons.photo_camera_outlined,
                    color: AppColors.white,
                    size: 19.w,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
