import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/images.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/language_menu_button.dart';
import '../../home/screen/home_screen.dart';
import '../logic/navigation_cubit.dart';
import '../widget/app_nav_bar.dart';
import '../widget/tab_placeholder.dart';

/// The main app after login: the selected tab above the navigation bar.
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.select((NavigationCubit cubit) => cubit.state.tab);
    String t(String key) => AppLocalization.translateKey(context, key);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        // IndexedStack keeps every tab alive, so switching tabs doesn't lose
        // what was typed. Children are in NavTab order.
        body: IndexedStack(
          index: current.index,
          children: [
            const HomeScreen(),
            TabPlaceholder(title: t('nav_history'), icon: AppImages.history),
            TabPlaceholder(title: t('nav_scanner'), icon: AppImages.scan),
            TabPlaceholder(
              title: t('nav_profile'),
              icon: AppImages.user,
              action: const LanguageMenuButton(),
            ),
          ],
        ),
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }
}
