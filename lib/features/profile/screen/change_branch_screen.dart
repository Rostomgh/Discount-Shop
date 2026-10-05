import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/page_header.dart';
import '../logic/profile_cubit.dart';
import '../model/branch_model.dart';
import '../widget/branch_card.dart';

/// The partner's branches; tapping one makes it the current branch. Opened
/// from the profile once the store is loaded.
class ChangeBranchScreen extends StatelessWidget {
  const ChangeBranchScreen({super.key});

  Future<void> _select(BuildContext context, String branchId) async {
    final cubit = context.read<ProfileCubit>();
    if (cubit.state case ProfileLoaded(
      :final store,
    ) when store.branchId == branchId) {
      Navigator.pop(context);
      return;
    }

    cubit.selectBranch(branchId);
    showToast(context, AppLocalization.translateKey(context, 'branch_changed'));
    // Let the check mark move before going back.
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final state = context.watch<ProfileCubit>().state;
    final (branches, branchId) = switch (state) {
      ProfileLoaded(:final branches, :final store) => (
        branches,
        store.branchId,
      ),
      _ => (const <BranchModel>[], null),
    };

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              PageHeader(
                title: t('change_branch'),
                subtitle: t('change_branch_subtitle'),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 16.h),
                  itemCount: branches.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (context, i) => FadeSlideIn(
                    delay: Duration(milliseconds: 80 * i),
                    child: BranchCard(
                      branch: branches[i],
                      selected: branches[i].id == branchId,
                      onTap: () => _select(context, branches[i].id),
                    ),
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
