import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../widget/confirm_number_header.dart';
import '../widget/otp_input.dart';
import '../widget/resend_code_row.dart';
import '../widget/sms_sent_text.dart';

class ConfirmNumberScreen extends StatelessWidget {
  const ConfirmNumberScreen({super.key, required this.phoneNumber});

  /// The number the activation SMS was sent to.
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 38.w),
          child: Column(
            children: [
              SizedBox(height: 114.h),
              const ConfirmNumberHeader(),
              SizedBox(height: 16.h),
              const ResendCodeRow(),
              SizedBox(height: 47.h),
              SmsSentText(phoneNumber: phoneNumber),
              SizedBox(height: 58.h),
              const OtpInput(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
