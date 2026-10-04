import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/enums.dart';
import '../../../core/constant/images.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../logic/navigation_cubit.dart';
import 'nav_bar_item.dart';

/// The floating bottom bar with the four tabs.
class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  static String _icon(NavTab tab) => switch (tab) {
    NavTab.home => AppImages.home,
    NavTab.history => AppImages.history,
    NavTab.scanner => AppImages.scan,
    NavTab.profile => AppImages.user,
  };

  static String _labelKey(NavTab tab) => switch (tab) {
    NavTab.home => 'nav_home',
    NavTab.history => 'nav_history',
    NavTab.scanner => 'nav_scanner',
    NavTab.profile => 'nav_profile',
  };

  @override
  Widget build(BuildContext context) {
    final current = context.select((NavigationCubit cubit) => cubit.state.tab);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
        child: Center(
          heightFactor: 1,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.divider),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 26.w,
              children: [
                for (final tab in NavTab.values)
                  NavBarItem(
                    icon: _icon(tab),
                    label: AppLocalization.translateKey(
                      context,
                      _labelKey(tab),
                    ),
                    selected: tab == current,
                    onTap: () => context.read<NavigationCubit>().selectTab(tab),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
