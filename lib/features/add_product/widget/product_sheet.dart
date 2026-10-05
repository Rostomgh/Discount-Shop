import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/discount_selector.dart';
import '../../../shared/widgets/field_label.dart';
import '../../../shared/widgets/labeled_text_field.dart';
import '../logic/add_product_cubit.dart';
import 'quick_tags.dart';

/// White panel under the camera with the product fields. Put it inside a
/// [Form]; the discount is validated with the text fields.
class ProductSheet extends StatelessWidget {
  const ProductSheet({
    super.key,
    required this.nameController,
    required this.categoryController,
    required this.priceController,
  });

  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController priceController;

  /// "1 500,5" -> 1500.5; null if it isn't a number.
  static double? parsePrice(String text) =>
      double.tryParse(text.replaceAll(RegExp(r'\s'), '').replaceAll(',', '.'));

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return Container(
      padding: EdgeInsets.fromLTRB(23.w, 12.h, 23.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 52.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.boxBorder,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          LabeledTextField(
            label: t('product_name'),
            hint: t('product_name_hint'),
            controller: nameController,
            validator: (value) =>
                (value ?? '').trim().isEmpty ? t('field_required') : null,
          ),
          SizedBox(height: 20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: LabeledTextField(
                  label: t('category'),
                  controller: categoryController,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                flex: 3,
                child: LabeledTextField(
                  label: t('price'),
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  textDirection: TextDirection.ltr,
                  validator: (value) {
                    final price = parsePrice(value ?? '');
                    return price == null || price <= 0
                        ? t('invalid_price')
                        : null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 22.h),
          FieldLabel(t('discount')),
          SizedBox(height: 12.h),
          const _DiscountField(),
          SizedBox(height: 22.h),
          FieldLabel(t('quick_tags')),
          SizedBox(height: 12.h),
          const QuickTags(),
        ],
      ),
    );
  }
}

/// The discount choices as a form field, so a missing discount shows an
/// error like the text fields.
class _DiscountField extends StatelessWidget {
  const _DiscountField();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();
    final selected = context.select((AddProductCubit c) => c.state.discount);

    return FormField<int>(
      validator: (_) => cubit.state.discount == null
          ? AppLocalization.translateKey(context, 'discount_required')
          : null,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DiscountSelector(
            discounts: AddProductCubit.discounts,
            selected: selected,
            onSelected: (discount) {
              cubit.selectDiscount(discount);
              field.didChange(discount);
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
