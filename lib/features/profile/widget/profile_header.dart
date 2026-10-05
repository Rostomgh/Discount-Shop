import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../model/store_model.dart';
import 'store_avatar.dart';

/// Store photo with the status badge, the store name and its email.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    final avatarSize = 124.w;

    return Column(
      children: [
        // The badge hangs over the bottom of the photo.
        SizedBox(
          width: avatarSize + 40.w,
          height: avatarSize + 14.h,
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.6, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) => Opacity(
                  opacity: ((scale - 0.6) / 0.4).clamp(0, 1),
                  child: Transform.scale(scale: scale, child: child),
                ),
                child: StoreAvatar(store: store, size: avatarSize),
              ),
              if (store.status.isNotEmpty)
                Positioned(
                  bottom: 0,
                  child: FadeSlideIn(
                    delay: const Duration(milliseconds: 250),
                    child: _StatusBadge(
                      text: AppLocalization.translateKey(context, store.status),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        FadeSlideIn(
          delay: const Duration(milliseconds: 120),
          child: Column(
            children: [
              Text(
                store.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                store.email,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Subscriber" pill under the photo.
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.white, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
