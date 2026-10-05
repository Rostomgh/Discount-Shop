import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/field_label.dart';
import '../../../shared/widgets/labeled_text_field.dart';
import 'discount_percent_field.dart';
import 'end_date_field.dart';

/// The fields of a new discount. Put it inside a [Form].
class DiscountForm extends StatelessWidget {
  const DiscountForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.percent,
    required this.onPercentChanged,
    required this.endDate,
    required this.onEndDateChanged,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final int? percent;
  final ValueChanged<int> onPercentChanged;
  final DateTime? endDate;
  final ValueChanged<DateTime?> onEndDateChanged;

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    final fields = [
      LabeledTextField(
        label: t('discount_title'),
        hint: t('discount_title_hint'),
        isRequired: true,
        controller: titleController,
        validator: (value) =>
            (value ?? '').trim().isEmpty ? t('field_required') : null,
      ),
      LabeledTextField(
        label: t('discount_description'),
        hint: t('discount_description_hint'),
        controller: descriptionController,
        textInputAction: TextInputAction.done,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FieldLabel(t('discount'), isRequired: true),
          SizedBox(height: 12.h),
          DiscountPercentField(selected: percent, onSelected: onPercentChanged),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FieldLabel(t('end_date')),
          SizedBox(height: 10.h),
          EndDateField(date: endDate, onChanged: onEndDateChanged),
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, field) in fields.indexed)
          Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: FadeSlideIn(
              delay: Duration(milliseconds: 80 * i),
              child: field,
            ),
          ),
      ],
    );
  }
}
