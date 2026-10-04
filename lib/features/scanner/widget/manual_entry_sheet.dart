import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/labeled_text_field.dart';
import '../logic/scanner_cubit.dart';

/// Bottom sheet to type the card number when the QR code can't be scanned.
/// Pops with the digits, without spaces.
class ManualEntrySheet extends StatefulWidget {
  const ManualEntrySheet({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ManualEntrySheet(),
    );
  }

  @override
  State<ManualEntrySheet> createState() => _ManualEntrySheetState();
}

class _ManualEntrySheetState extends State<ManualEntrySheet> {
  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();

  @override
  void dispose() {
    _number.dispose();
    super.dispose();
  }

  String get _digits => _number.text.replaceAll(' ', '');

  void _submit() {
    if (_formKey.currentState!.validate()) Navigator.pop(context, _digits);
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return Padding(
      // Stays above the keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 52.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: AppColors.boxBorder,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    t('manual_entry_title'),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    t('manual_entry_hint'),
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15.sp,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  LabeledTextField(
                    label: t('card_number'),
                    isRequired: true,
                    hint: '0000 0000 0000',
                    controller: _number,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    textDirection: TextDirection.ltr,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(ScannerCubit.cardDigits),
                      const _GroupDigitsFormatter(),
                    ],
                    validator: (_) => _digits.length == ScannerCubit.cardDigits
                        ? null
                        : t('invalid_card_number'),
                  ),
                  SizedBox(height: 24.h),
                  GradientButton(text: t('validate'), onPressed: _submit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows the digits in groups of 4, like on the card: "0942 8133 9901".
/// Comes after [FilteringTextInputFormatter.digitsOnly], which removes the
/// spaces added on the previous edit.
class _GroupDigitsFormatter extends TextInputFormatter {
  const _GroupDigitsFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = ScannerCubit.formatCode(newValue.text);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
