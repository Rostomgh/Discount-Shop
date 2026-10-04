import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../core/extensions/bidi.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/status_message.dart';
import '../logic/home_cubit.dart';
import '../model/product_model.dart';
import 'category_filter.dart';
import 'product_card.dart';
import 'product_list_skeleton.dart';

/// Slivers under the header: title, category filter and the product list
/// (or its loading, empty and error states).
class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final state = context.watch<HomeCubit>().state;
    final padding = EdgeInsets.symmetric(horizontal: 20.w);

    final Widget body = switch (state) {
      HomeInitial() || HomeLoading() => SliverPadding(
        padding: padding,
        sliver: const SliverToBoxAdapter(child: ProductListSkeleton()),
      ),
      HomeError() => SliverToBoxAdapter(
        child: StatusMessage(
          icon: Icons.cloud_off_outlined,
          title: t('load_error'),
          action: TextButton(
            onPressed: context.read<HomeCubit>().loadProducts,
            child: Text(t('retry')),
          ),
        ),
      ),
      HomeLoaded(:final products, :final category) => () {
        final shown = category == null
            ? products
            : products.where((p) => p.category == category).toList();
        if (shown.isEmpty) {
          return SliverToBoxAdapter(
            child: StatusMessage(
              icon: Icons.local_offer_outlined,
              title: t('no_products'),
              subtitle: t('no_products_hint'),
            ),
          );
        }
        return SliverPadding(
          padding: padding,
          sliver: SliverList.separated(
            itemCount: shown.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (_, i) => FadeSlideIn(
              key: ValueKey(shown[i].id),
              // Items arrive one after another, the first few at least.
              delay: Duration(milliseconds: 70 * min(i, 6)),
              child: ProductCard(product: shown[i]),
            ),
          ),
        );
      }(),
    };

    final loaded = state is HomeLoaded ? state : null;
    final categories = <String>{
      for (final p in loaded?.products ?? const <ProductModel>[])
        if (p.category.isNotEmpty) p.category,
    }.toList()..sort();

    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 14.h),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    t('my_products'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                if (loaded != null)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Container(
                      key: ValueKey(loaded.products.length),
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.chipBackground,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${loaded.products.length}'.ltrIsolated,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (loaded != null && categories.isNotEmpty)
          SliverPadding(
            padding: EdgeInsets.only(bottom: 16.h),
            sliver: SliverToBoxAdapter(
              child: CategoryFilter(
                categories: categories,
                selected: loaded.category,
                onSelected: context.read<HomeCubit>().selectCategory,
              ),
            ),
          ),
        body,
      ],
    );
  }
}
