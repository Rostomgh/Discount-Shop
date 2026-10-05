import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/enums.dart';
import '../../../core/constant/theme/colors.dart';
import '../../history/screen/history_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../../scanner/screen/scanner_screen.dart';
import '../logic/navigation_cubit.dart';
import '../widget/app_nav_bar.dart';

/// The main app after login: the selected tab above the navigation bar.
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // Tabs are built the first time they're opened, so they load their data
  // and play their entrance animations when the partner actually sees them.
  final _opened = <NavTab>{};

  Widget _tab(NavTab tab, NavTab current) {
    return switch (tab) {
      NavTab.home => const HomeScreen(),
      NavTab.history => const HistoryScreen(),
      NavTab.scanner => ScannerScreen(active: current == NavTab.scanner),
      NavTab.profile => const ProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final current = context.select((NavigationCubit cubit) => cubit.state.tab);
    _opened.add(current);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        // IndexedStack keeps opened tabs alive, so switching tabs doesn't lose
        // what was typed or scrolled.
        body: IndexedStack(
          index: current.index,
          children: [
            for (final tab in NavTab.values)
              _opened.contains(tab)
                  ? _tab(tab, current)
                  : const SizedBox.shrink(),
          ],
        ),
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }
}
