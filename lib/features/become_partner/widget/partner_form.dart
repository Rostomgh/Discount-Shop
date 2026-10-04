import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/localization/app_ localization.dart';
import 'partner_field.dart';

/// The fields of the partner request.
class PartnerForm extends StatelessWidget {
  const PartnerForm({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final gap = SizedBox(height: 20.h);

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PartnerField(
            label: t('company_name'),
            isRequired: true,
            autofillHints: const [AutofillHints.organizationName],
          ),
          gap,
          PartnerField(label: t('business_category'), isRequired: true),
          gap,
          PartnerField(
            label: t('branch_count'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          gap,
          PartnerField(
            label: t('contact_name'),
            isRequired: true,
            keyboardType: TextInputType.name,
            autofillHints: const [AutofillHints.name],
          ),
          gap,
          PartnerField(
            label: t('email_address'),
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
          ),
          gap,
          PartnerField(
            label: t('phone_number'),
            isRequired: true,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.telephoneNumber],
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
