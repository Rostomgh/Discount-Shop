import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';

/// "Transaction History" and the line under it.
class HistoryTitle extends StatelessWidget {
  const HistoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return FadeSlideIn(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            Text(
              t('history_title'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 23.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              t('history_subtitle'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16.sp,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
