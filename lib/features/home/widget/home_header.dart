import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/grid_background.dart';
import '../model/product_model.dart';
import 'stat_tile.dart';

/// Blue top of the home tab: title and numbers about the discounts.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.products});

  /// Empty while loading; the numbers count up once they arrive.
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final discounts = products.map((p) => p.discount);
    final average = discounts.isEmpty
        ? 0
        : discounts.reduce((a, b) => a + b) / discounts.length;
    final best = discounts.isEmpty
        ? 0
        : discounts.reduce((a, b) => a > b ? a : b);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(28.r)),
      child: GridBackground(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t('home_title'),
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  t('home_subtitle'),
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.8),
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        value: products.length,
                        label: t('stat_products'),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: StatTile(
                        value: average,
                        suffix: '%',
                        label: t('stat_average'),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: StatTile(
                        value: best,
                        suffix: '%',
                        label: t('stat_best'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
