import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    const line = Expanded(
      child: Divider(color: AppColors.divider, thickness: 1, height: 1),
    );

    return Row(
      children: [
        line,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          // Long translations or big system fonts get "..." instead of
          // overflowing the card.
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 220.w),
            child: Text(
              AppLocalization.translateKey(context, 'or_connect_with'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
            ),
          ),
        ),
        line,
      ],
    );
  }
}
