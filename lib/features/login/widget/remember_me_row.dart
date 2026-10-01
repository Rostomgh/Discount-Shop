import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

class RememberMeRow extends StatefulWidget {
  const RememberMeRow({super.key, this.onForgotPassword});

  final VoidCallback? onForgotPassword;

  @override
  State<RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<RememberMeRow> {
  bool _remember = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Both sides are Flexible so long translations get "..." instead
        // of overflowing.
        Flexible(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _remember = !_remember),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CheckBox(checked: _remember),
                SizedBox(width: 9.w),
                Flexible(
                  child: Text(
                    AppLocalization.translateKey(context, 'remember_me'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.hint, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: GestureDetector(
            onTap: widget.onForgotPassword,
            child: Text(
              AppLocalization.translateKey(context, 'forgot_password'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15.w,
      height: 15.w,
      decoration: BoxDecoration(
        color: checked ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(3.r),
        border: Border.all(
          color: checked ? AppColors.primary : AppColors.hint,
          width: 1.2,
        ),
      ),
      child: checked
          ? Icon(Icons.check, size: 12.w, color: AppColors.white)
          : null,
    );
  }
}
