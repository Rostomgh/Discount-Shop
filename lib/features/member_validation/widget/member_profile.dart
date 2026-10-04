import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../model/member_model.dart';

/// Photo with the status badge, name, and how the card was checked.
class MemberProfile extends StatelessWidget {
  const MemberProfile({super.key, required this.member, required this.scanned});

  final MemberModel member;

  /// The QR code was scanned; false when the number was typed.
  final bool scanned;

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
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
                child: _Avatar(member: member, size: avatarSize),
              ),
              Positioned(
                bottom: 0,
                child: FadeSlideIn(
                  delay: const Duration(milliseconds: 250),
                  child: _StatusBadge(text: t(member.status)),
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
                member.name,
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    scanned ? Icons.verified_outlined : Icons.keyboard_outlined,
                    color: scanned
                        ? AppColors.success
                        : AppColors.textSecondary,
                    size: 18.w,
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Text(
                      t(
                        scanned
                            ? 'identity_verified_qr'
                            : 'identity_entered_manually',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Round photo with a blue ring; the initials when there is no photo.
class _Avatar extends StatelessWidget {
  const _Avatar({required this.member, required this.size});

  final MemberModel member;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initials = Center(
      child: Text(
        member.initials,
        style: TextStyle(
          color: AppColors.white,
          fontSize: size * 0.34,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
    final photoUrl = member.photoUrl;

    return Container(
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
          child: photoUrl == null
              ? initials
              : Image.network(
                  photoUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, _, _) => initials,
                ),
        ),
      ),
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
