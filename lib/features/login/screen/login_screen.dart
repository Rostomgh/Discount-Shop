import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../widget/login_background.dart';
import '../widget/login_card.dart';
import '../widget/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    // Dark status bar icons on the light top, blue navigation bar at the bottom.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.primary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 90.h),
                    const LoginHeader(),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          // The blue starts behind the middle of the card
                          // and fills the rest of the screen.
                          Positioned.fill(
                            top: 143.h,
                            child: const LoginBackground(),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              24.w,
                              0,
                              24.w,
                              bottomInset + 12.h,
                            ),
                            child: const LoginCard(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
