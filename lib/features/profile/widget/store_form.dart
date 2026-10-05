import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/labeled_text_field.dart';

/// The store's editable details. Put it inside a [Form].
class StoreForm extends StatelessWidget {
  const StoreForm({
    super.key,
    required this.nameController,
    required this.categoryController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
  });

  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    String? required(String? value) =>
        (value ?? '').trim().isEmpty ? t('field_required') : null;

    final fields = [
      LabeledTextField(
        label: t('store_name'),
        isRequired: true,
        controller: nameController,
        autofillHints: const [AutofillHints.organizationName],
        validator: required,
      ),
      LabeledTextField(
        label: t('business_category'),
        controller: categoryController,
      ),
      LabeledTextField(
        label: t('email_address'),
        isRequired: true,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        textDirection: TextDirection.ltr,
        validator: (value) {
          final email = (value ?? '').trim();
          if (email.isEmpty) return t('field_required');
          return RegExp(r'^\S+@\S+\.\S+$').hasMatch(email)
              ? null
              : t('invalid_email');
        },
      ),
      LabeledTextField(
        label: t('phone_number'),
        controller: phoneController,
        keyboardType: TextInputType.phone,
        autofillHints: const [AutofillHints.telephoneNumber],
        textDirection: TextDirection.ltr,
      ),
      LabeledTextField(
        label: t('address'),
        controller: addressController,
        keyboardType: TextInputType.streetAddress,
        textInputAction: TextInputAction.done,
        autofillHints: const [AutofillHints.fullStreetAddress],
      ),
    ];

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, field) in fields.indexed)
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: FadeSlideIn(
                delay: Duration(milliseconds: 100 + 60 * i),
                child: field,
              ),
            ),
        ],
      ),
    );
  }
}
