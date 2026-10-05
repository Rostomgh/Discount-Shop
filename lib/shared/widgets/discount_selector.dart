import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/theme/colors.dart';
import '../../core/extensions/bidi.dart';

/// Row of "-10%", "-20%"... choices; the selected one is filled blue.
class DiscountSelector extends StatelessWidget {
  const DiscountSelector({
    super.key,
    required this.discounts,
    this.selected,
    this.onSelected,
  });

  final List<int> discounts;
  final int? selected;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final discount in discounts)
          _DiscountChip(
            discount: discount,
            selected: discount == selected,
            onTap: () => onSelected?.call(discount),
          ),
      ],
    );
  }
}

class _DiscountChip extends StatelessWidget {
  const _DiscountChip({
    required this.discount,
    required this.selected,
    required this.onTap,
  });

  final int discount;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.r);

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              gradient: selected
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.primaryLight, AppColors.primary],
                    )
                  : null,
              color: selected ? null : AppColors.white,
              borderRadius: radius,
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Text(
              '-$discount%'.ltrIsolated,
              style: TextStyle(
                color: selected ? AppColors.white : AppColors.textPrimary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
