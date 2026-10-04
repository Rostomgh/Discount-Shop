import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../core/extensions/price.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../model/offer_model.dart';

/// One offer the partner can pick; the picked one turns blue with a check.
class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.offer,
    required this.selected,
    this.onTap,
  });

  final OfferModel offer;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final radius = BorderRadius.circular(16.r);
    const duration = Duration(milliseconds: 220);

    final cost = offer.pointsCost;
    var description = t(offer.description);
    if (cost != null) {
      description += ' (${(-cost).asSignedPrice} ${t('points_unit')})';
    }

    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected ? AppColors.chipBackground : AppColors.white,
          borderRadius: radius,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: selected ? 14 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: duration,
                    child: Icon(
                      Icons.local_offer_outlined,
                      key: ValueKey(selected),
                      color: selected ? AppColors.primary : AppColors.hint,
                      size: 26.w,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t(offer.title),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  AnimatedScale(
                    scale: selected ? 1 : 0,
                    duration: duration,
                    curve: Curves.easeOutBack,
                    child: Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
