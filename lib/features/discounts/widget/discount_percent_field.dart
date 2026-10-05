import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/discount_selector.dart';
import '../logic/discounts_cubit.dart';

/// The percentage choices as a form field, so a missing percentage shows an
/// error like the text fields. Put it inside a [Form].
class DiscountPercentField extends StatelessWidget {
  const DiscountPercentField({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final int? selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      initialValue: selected,
      // The field's own value is up to date even before the next rebuild.
      validator: (value) => value == null
          ? AppLocalization.translateKey(context, 'discount_required')
          : null,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DiscountSelector(
            discounts: DiscountsCubit.percents,
            selected: selected,
            onSelected: (percent) {
              onSelected(percent);
              field.didChange(percent);
            },
          ),
          if (field.errorText != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                field.errorText!,
                style: TextStyle(color: AppColors.error, fontSize: 12.sp),
              ),
            ),
        ],
      ),
    );
  }
}
