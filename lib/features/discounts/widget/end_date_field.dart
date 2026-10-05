import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// Looks like a text field; opens a calendar to pick the discount's last
/// day. The cross clears it (the discount never ends).
class EndDateField extends StatelessWidget {
  const EndDateField({super.key, required this.date, required this.onChanged});

  final DateTime? date;
  final ValueChanged<DateTime?> onChanged;

  Future<void> _pick(BuildContext context) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: date ?? today.add(const Duration(days: 7)),
      firstDate: today,
      lastDate: today.add(const Duration(days: 365 * 2)),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final radius = BorderRadius.circular(14.r);
    final date = this.date;

    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: () => _pick(context),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(14.w, 4.h, 4.w, 4.h),
          child: Row(
            children: [
              Icon(
                Icons.event_outlined,
                color: date == null ? AppColors.icon : AppColors.primary,
                size: 22.w,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  layoutBuilder: (current, previous) => Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [...previous, ?current],
                  ),
                  child: Text(
                    date == null
                        ? AppLocalization.translateKey(context, 'no_end_date')
                        : (DateFormat.yMMMd(
                            locale,
                          )..useNativeDigits = false).format(date),
                    key: ValueKey(date),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: date == null
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              // Keeps the field's height the same with or without the cross.
              SizedBox(
                height: 46.h,
                child: date == null
                    ? null
                    : IconButton(
                        tooltip: AppLocalization.translateKey(context, 'clear'),
                        onPressed: () => onChanged(null),
                        icon: Icon(
                          Icons.close,
                          color: AppColors.icon,
                          size: 20.w,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
