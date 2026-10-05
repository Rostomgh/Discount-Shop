import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../core/extensions/bidi.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../model/discount_model.dart';

/// One discount: its percentage, title, end date, an on/off switch and a
/// delete button. Turned-off discounts are grayed.
class DiscountCard extends StatelessWidget {
  const DiscountCard({
    super.key,
    required this.discount,
    this.onActiveChanged,
    this.onDelete,
  });

  final DiscountModel discount;
  final ValueChanged<bool>? onActiveChanged;
  final VoidCallback? onDelete;

  String _endDate(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final end = discount.endDate;
    if (end == null) return t('no_end_date');

    final today = DateUtils.dateOnly(DateTime.now());
    if (end.isBefore(today)) return t('discount_expired');
    final locale = Localizations.localeOf(context).languageCode;
    final date = (DateFormat.MMMd(locale)..useNativeDigits = false).format(end);
    return '${t('valid_until')} $date';
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 250);
    final active = discount.active;

    return AnimatedContainer(
      duration: duration,
      padding: EdgeInsetsDirectional.fromSTEB(14.w, 14.h, 6.w, 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: active ? 0.04 : 0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // The percentage, blue while the discount is on.
          AnimatedContainer(
            duration: duration,
            width: 64.w,
            height: 64.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: active
                    ? const [AppColors.primaryLight, AppColors.primary]
                    : const [AppColors.hint, AppColors.icon],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              '-${discount.percent}%'.ltrIsolated,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: AnimatedOpacity(
              duration: duration,
              opacity: active ? 1 : 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    discount.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (discount.description.isNotEmpty) ...[
                    SizedBox(height: 3.h),
                    Text(
                      discount.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.event_outlined,
                        color: AppColors.textSecondary,
                        size: 15.w,
                      ),
                      SizedBox(width: 5.w),
                      Flexible(
                        child: Text(
                          _endDate(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Switch(
                value: active,
                onChanged: onActiveChanged,
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: AppColors.divider,
                inactiveThumbColor: AppColors.white,
                trackOutlineColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
              ),
              IconButton(
                tooltip: AppLocalization.translateKey(context, 'delete'),
                onPressed: onDelete,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: 22.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
