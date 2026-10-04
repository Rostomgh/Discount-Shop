import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../widget/partner_form.dart';
import '../widget/terms_notice.dart';
import '../widget/top_glow.dart';

class BecomePartnerScreen extends StatelessWidget {
  const BecomePartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            const TopGlow(),
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                38.w,
                padding.top + 26.h,
                38.w,
                padding.bottom + 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalization.translateKey(context, 'become_partner'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  const PartnerForm(),
                  SizedBox(height: 28.h),
                  GradientButton(
                    text: AppLocalization.translateKey(context, 'send_request'),
                    // TODO: send the request with the become_partner cubit.
                    onPressed: () {},
                  ),
                  SizedBox(height: 30.h),
                  const TermsNotice(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
