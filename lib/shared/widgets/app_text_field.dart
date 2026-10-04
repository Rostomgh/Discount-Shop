import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/theme/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.inputFormatters,
    this.textDirection,
    this.suffix,
  });

  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;

  /// Set to [TextDirection.ltr] for phone numbers so they don't get
  /// reordered in Arabic.
  final TextDirection? textDirection;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: AppColors.textPrimary, fontSize: 16.sp);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      textDirection: textDirection,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textStyle.copyWith(color: AppColors.hint),
        filled: true,
        fillColor: AppColors.white,
        isDense: true,
        // Vertical padding gives the 54 px field height from the design.
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
        suffixIcon: suffix == null
            ? null
            : Padding(
                padding: EdgeInsetsDirectional.only(end: 13.w),
                child: suffix,
              ),
        suffixIconConstraints: const BoxConstraints(),
        enabledBorder: _border(AppColors.border),
        focusedBorder: _border(AppColors.primary),
      ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: color),
    );
  }
}
