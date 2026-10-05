import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../logic/lang_cubit/lang_cubit.dart';

/// Pill with the three languages; the current one is filled blue.
class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  // Each language is written in itself, so it can be found from any other.
  static const _languages = [
    ('en', 'English'),
    ('fr', 'Français'),
    ('ar', 'عربي'),
  ];

  @override
  Widget build(BuildContext context) {
    final current = context.select(
      (LangCubit cubit) => cubit.state.locale.languageCode,
    );

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (code, name) in _languages)
            _Option(
              name: name,
              selected: code == current,
              onTap: () => context.read<LangCubit>().changeLang(Locale(code)),
            ),
        ],
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 250);
    final radius = BorderRadius.circular(19.r);

    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: selected ? null : onTap,
          child: AnimatedContainer(
            duration: duration,
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 7.h),
            decoration: BoxDecoration(
              gradient: selected
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.primaryLight, AppColors.primary],
                    )
                  : null,
              borderRadius: radius,
              boxShadow: [
                if (selected)
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: AnimatedDefaultTextStyle(
              duration: duration,
              style: TextStyle(
                color: selected ? AppColors.white : AppColors.textSecondary,
                fontSize: 13.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
              child: Text(name),
            ),
          ),
        ),
      ),
    );
  }
}
