import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    );
  }
}
