import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

// Unicode "left-to-right isolate" start and end. Wrapping the phone number in
// them keeps "+213 ..." in the right order inside Arabic text.
final _ltrIsolateStart = String.fromCharCode(0x2066);
final _ltrIsolateEnd = String.fromCharCode(0x2069);

class SmsSentText extends StatelessWidget {
  const SmsSentText({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: AppLocalization.translateKey(context, 'sms_code_sent'),
        children: [
          if (phoneNumber.isNotEmpty)
            TextSpan(
              text: ' $_ltrIsolateStart$phoneNumber$_ltrIsolateEnd',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.textBody,
        fontSize: 18.sp,
        height: 1.6,
      ),
    );
  }
}
