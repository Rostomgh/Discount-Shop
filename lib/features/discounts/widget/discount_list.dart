import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/widgets/fade_slide_in.dart';
import '../model/discount_model.dart';
import 'discount_card.dart';

/// The discounts, arriving one after another.
class DiscountList extends StatelessWidget {
  const DiscountList({
    super.key,
    required this.discounts,
    required this.onActiveChanged,
    required this.onDelete,
  });

  final List<DiscountModel> discounts;
  final void Function(String id, bool active) onActiveChanged;
  final ValueChanged<DiscountModel> onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
      itemCount: discounts.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, i) {
        final discount = discounts[i];
        // Keyed by id, so the others don't animate again when one is
        // added or deleted.
        return FadeSlideIn(
          key: ValueKey(discount.id),
          delay: Duration(milliseconds: 70 * i.clamp(0, 6)),
          child: DiscountCard(
            discount: discount,
            onActiveChanged: (active) => onActiveChanged(discount.id, active),
            onDelete: () => onDelete(discount),
          ),
        );
      },
    );
  }
}
