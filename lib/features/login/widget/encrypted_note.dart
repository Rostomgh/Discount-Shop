import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

class EncryptedNote extends StatelessWidget {
  const EncryptedNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalization.translateKey(context, 'encrypted_connection'),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.textMuted,
        fontSize: 13.sp,
        letterSpacing: 1.1,
      ),
    );
  }
}
