import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

class ResendCodeRow extends StatelessWidget {
  const ResendCodeRow({super.key, this.onResend});

  final VoidCallback? onResend;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: AppColors.primary,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );

    // Wrap moves "Resend" to the next line if a translation is too long.
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6.w,
      children: [
        Text(
          AppLocalization.translateKey(context, 'code_not_received'),
          style: style,
        ),
        GestureDetector(
          onTap: onResend,
          child: Text(
            AppLocalization.translateKey(context, 'resend'),
            style: style.copyWith(
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
