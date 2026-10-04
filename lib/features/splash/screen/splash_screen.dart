import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/theme/colors.dart';
import '../widget/splash_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const Duration duration = Duration(seconds: 4);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(SplashScreen.duration, _goNext);
  }

  void _goNext() {
    // Skip if another screen is already on top (e.g. app opened with --es route /login).
    if (!mounted || !(ModalRoute.of(context)?.isCurrent ?? true)) return;
    // Replace the splash so the back button doesn't return to it.
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
