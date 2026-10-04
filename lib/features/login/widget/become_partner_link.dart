import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// "Not a partner yet? Become a Partner", opens the partner request form.
class BecomePartnerLink extends StatelessWidget {
  const BecomePartnerLink({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap moves the link to the next line if a translation is too long.
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6.w,
      children: [
        Text(
          AppLocalization.translateKey(context, 'not_partner_yet'),
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.becomePartner),
          child: Text(
            AppLocalization.translateKey(context, 'become_partner'),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
