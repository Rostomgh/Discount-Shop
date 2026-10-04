import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/theme/colors.dart';

/// The label above a form field; required fields get a " *" after it.
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key, this.isRequired = false});

  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Text(
      isRequired ? '$text *' : text,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15.sp,
        letterSpacing: 0.3,
      ),
    );
  }
}
