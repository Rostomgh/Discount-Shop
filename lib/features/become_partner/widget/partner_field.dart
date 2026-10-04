import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/widgets/app_text_field.dart';

/// A label above a text field; required fields get a " *" after the label.
class PartnerField extends StatelessWidget {
  const PartnerField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.inputFormatters,
    this.textDirection,
  });

  final String label;
  final bool isRequired;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '$label *' : label,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15.sp,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 10.h),
        AppTextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          inputFormatters: inputFormatters,
          textDirection: textDirection,
        ),
      ],
    );
  }
}
