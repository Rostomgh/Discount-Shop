import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/localization/app_ localization.dart';
import 'category_chip.dart';

/// Scrollable row of category filters, starting with "All".
class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
    required this.categories,
    this.selected,
    required this.onSelected,
  });

  final List<String> categories;

  /// Null means "All".
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final items = <String?>[null, ...categories];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: items.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, i) => Center(
          child: CategoryChip(
            label:
                items[i] ??
                AppLocalization.translateKey(context, 'all_categories'),
            selected: items[i] == selected,
            onTap: () => onSelected(items[i]),
          ),
        ),
      ),
    );
  }
}
