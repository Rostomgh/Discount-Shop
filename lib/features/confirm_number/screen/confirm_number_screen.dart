import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../widget/confirm_button.dart';
import '../widget/confirm_number_header.dart';
import '../widget/otp_input.dart';
import '../widget/resend_code_row.dart';
import '../widget/sms_sent_text.dart';

class ConfirmNumberScreen extends StatefulWidget {
  const ConfirmNumberScreen({super.key, required this.phoneNumber});

  /// The number the activation SMS was sent to.
  final String phoneNumber;

  @override
  State<ConfirmNumberScreen> createState() => _ConfirmNumberScreenState();
}

class _ConfirmNumberScreenState extends State<ConfirmNumberScreen> {
  static const _codeLength = 4;

  String _code = '';

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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 38.w),
                child: Column(
                  children: [
                    SizedBox(height: 114.h),
                    const ConfirmNumberHeader(),
                    SizedBox(height: 16.h),
                    const ResendCodeRow(),
                    SizedBox(height: 47.h),
                    SmsSentText(phoneNumber: widget.phoneNumber),
                    SizedBox(height: 58.h),
                    OtpInput(
                      length: _codeLength,
                      onChanged: (code) => setState(() => _code = code),
                      // Hide the keyboard so the whole screen and the
                      // button are visible.
                      onCompleted: (_) => FocusScope.of(context).unfocus(),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            // Outside the scroll view so it stays at the bottom, above the
            // keyboard when it's open.
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(29.w, 0, 29.w, 40.h),
                child: ConfirmButton(
                  visible: _code.length == _codeLength,
                  // TODO: verify the code with the confirm_number cubit.
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
