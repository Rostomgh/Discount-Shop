import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constant/theme/colors.dart';
import '../widget/splash_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Blue status and navigation bars with white icons, like the design.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.primary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: const Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(child: SplashLogo()),
      ),
    );
  }
}
