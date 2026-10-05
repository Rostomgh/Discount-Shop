import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../model/branch_model.dart';

/// One of the partner's branches; the current one turns blue with a check.
class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.branch,
    required this.selected,
    this.onTap,
  });

  final BranchModel branch;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.r);
    const duration = Duration(milliseconds: 220);

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
                  AnimatedContainer(
                    duration: duration,
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.chipBackground,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Icon(
                      Icons.storefront_outlined,
                      color: selected ? AppColors.white : AppColors.primary,
                      size: 24.w,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          branch.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (branch.address.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            branch.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
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
