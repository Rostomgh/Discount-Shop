import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import 'encrypted_note.dart';
import 'google_button.dart';
import 'gradient_button.dart';
import 'login_text_field.dart';
import 'or_divider.dart';
import 'password_field.dart';
import 'remember_me_row.dart';
import 'verified_chip.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.w, 29.h, 30.w, 30.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(13.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GoogleButton(),
          SizedBox(height: 30.h),
          const OrDivider(),
          SizedBox(height: 30.h),
          LoginTextField(
            hint: AppLocalization.translateKey(context, 'partner_id'),
            suffix: const VerifiedChip(),
          ),
          SizedBox(height: 19.h),
          const PasswordField(),
          SizedBox(height: 24.h),
          const RememberMeRow(),
          SizedBox(height: 24.h),
          GradientButton(
            text: AppLocalization.translateKey(context, 'activate_account'),
            // TODO: once the login cubit exists, navigate after the API call
            // and pass the phone number as the route argument.
            onPressed: () =>
                Navigator.pushNamed(context, Routes.confirmNumber),
          ),
          SizedBox(height: 26.h),
          const EncryptedNote(),
        ],
      ),
    );
  }
}
