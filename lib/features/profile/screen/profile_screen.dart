import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../../../core/constant/enums.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/status_message.dart';
import '../../discounts/logic/discounts_cubit.dart';
import '../../navigation/logic/navigation_cubit.dart';
import '../logic/profile_cubit.dart';
import '../widget/app_version_text.dart';
import '../widget/language_switch.dart';
import '../widget/logout_button.dart';
import '../widget/profile_header.dart';
import '../widget/profile_header_skeleton.dart';
import '../widget/settings_section.dart';
import '../widget/settings_tile.dart';

/// Fourth tab of the navigation bar: the store, its settings and log out.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProfileCubit>();
    if (cubit.state is ProfileInitial) cubit.load();
  }

  String t(String key) => AppLocalization.translateKey(context, key);

  void _open(String route) => Navigator.pushNamed(context, route);

  Future<void> _logout() async {
    final confirmed = await ConfirmDialog.show(
      context,
      icon: Icons.logout,
      title: t('log_out_title'),
      message: t('log_out_message'),
      confirmText: t('log_out_confirm'),
    );
    if (!confirmed || !mounted) return;

    // Read before leaving: this screen goes away with the navigation bar.
    final profile = context.read<ProfileCubit>();
    final discounts = context.read<DiscountsCubit>();
    final navigation = context.read<NavigationCubit>();
    // TODO: clear the saved tokens (PersistData) once login uses the API.
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_) => false);
    // The next partner to log in starts on the home tab with fresh data.
    profile.reset();
    discounts.reset();
    navigation.selectTab(NavTab.home);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    // The store screens edit the loaded store, so they wait for it.
    final loaded = state is ProfileLoaded;

    // Entrance animation of the sections, one after another.
    var index = 0;
    Widget item(Widget child) => FadeSlideIn(
      delay: Duration(milliseconds: 150 + 70 * index++),
      child: child,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: ColoredBox(
        color: AppColors.white,
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 24.h),
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: switch (state) {
                  ProfileLoaded(:final store) => ProfileHeader(store: store),
                  ProfileError() => StatusMessage(
                    icon: Icons.storefront_outlined,
                    title: t('profile_load_error'),
                    action: TextButton(
                      onPressed: context.read<ProfileCubit>().load,
                      child: Text(t('retry')),
                    ),
                  ),
                  _ => const ProfileHeaderSkeleton(),
                },
              ),
              SizedBox(height: 34.h),
              item(
                SettingsSection(
                  title: t('section_account'),
                  children: [
                    SettingsTile(
                      icon: Icons.person_outline,
                      title: t('store_information'),
                      onTap: loaded
                          ? () => _open(Routes.storeInformation)
                          : null,
                    ),
                    SettingsTile(
                      icon: Icons.storefront_outlined,
                      title: t('change_branch'),
                      onTap: loaded ? () => _open(Routes.changeBranch) : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              item(
                SettingsSection(
                  title: t('section_discounts'),
                  children: [
                    SettingsTile(
                      icon: Icons.discount_outlined,
                      title: t('add_discounts'),
                      onTap: () => _open(Routes.addDiscount),
                    ),
                    SettingsTile(
                      icon: Icons.local_offer_outlined,
                      title: t('manage_discounts'),
                      onTap: () => _open(Routes.manageDiscounts),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              item(
                SettingsSection(
                  title: t('section_app_settings'),
                  children: [
                    SettingsTile(
                      icon: Icons.language,
                      title: t('language'),
                      showChevron: false,
                      trailing: const LanguageSwitch(),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      title: t('appearance'),
                      value: t('appearance_light'),
                      showChevron: false,
                      onTap: () => showToast(
                        context,
                        t('dark_mode_soon'),
                        type: ToastificationType.info,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              item(LogoutButton(onPressed: _logout)),
              SizedBox(height: 16.h),
              item(const AppVersionText()),
            ],
          ),
        ),
      ),
    );
  }
}
