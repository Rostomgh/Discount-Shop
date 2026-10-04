import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// "By submitting this form, you agree to our Terms and Conditions".
class TermsNotice extends StatelessWidget {
  const TermsNotice({super.key, this.onTermsTap});

  final VoidCallback? onTermsTap;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: AppColors.textSecondary,
      fontSize: 14.sp,
      height: 1.5,
    );

    return Column(
      children: [
        Text(
          AppLocalization.translateKey(context, 'terms_notice'),
          textAlign: TextAlign.center,
          style: style,
        ),
        GestureDetector(
          onTap: onTermsTap,
          child: Text(
            AppLocalization.translateKey(context, 'terms_and_conditions'),
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: AppColors.primaryLight,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryLight,
            ),
          ),
        ),
      ],
    );
  }
}
