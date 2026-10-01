import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/constant.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

class AppVersionText extends StatelessWidget {
  const AppVersionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${AppLocalization.translateKey(context, 'app_version')} '
      '${AppConstants.appVersion}',
      style: TextStyle(color: AppColors.white, fontSize: 15.sp),
    );
  }
}
