import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/status_message.dart';
import '../logic/discounts_cubit.dart';
import '../model/discount_model.dart';
import '../widget/discount_list.dart';
import '../widget/discount_list_skeleton.dart';

/// The partner's discounts: turn them on or off, delete them, add new ones.
class ManageDiscountsScreen extends StatefulWidget {
  const ManageDiscountsScreen({super.key});

  @override
  State<ManageDiscountsScreen> createState() => _ManageDiscountsScreenState();
}

class _ManageDiscountsScreenState extends State<ManageDiscountsScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<DiscountsCubit>();
    if (cubit.state is DiscountsInitial) cubit.load();
  }

  String t(String key) => AppLocalization.translateKey(context, key);

  Future<void> _delete(DiscountModel discount) async {
    final cubit = context.read<DiscountsCubit>();
    final confirmed = await ConfirmDialog.show(
      context,
      icon: Icons.delete_outline,
      title: t('delete_discount_title'),
      message: t('delete_discount_message'),
      confirmText: t('delete'),
    );
    if (!confirmed || !mounted) return;
    cubit.delete(discount.id);
    showToast(context, t('discount_deleted'));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DiscountsCubit>();
    final state = context.watch<DiscountsCubit>().state;

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
                title: t('manage_discounts'),
                subtitle: t('manage_discounts_subtitle'),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: switch (state) {
                    DiscountsLoaded(:final discounts) when discounts.isEmpty =>
                      SingleChildScrollView(
                        child: StatusMessage(
                          icon: Icons.local_offer_outlined,
                          title: t('no_discounts'),
                          subtitle: t('no_discounts_hint'),
                        ),
                      ),
                    DiscountsLoaded(:final discounts) => DiscountList(
                      discounts: discounts,
                      onActiveChanged: cubit.setActive,
                      onDelete: _delete,
                    ),
                    DiscountsError() => SingleChildScrollView(
                      child: StatusMessage(
                        icon: Icons.cloud_off_outlined,
                        title: t('discounts_load_error'),
                        action: TextButton(
                          onPressed: cubit.load,
                          child: Text(t('retry')),
                        ),
                      ),
                    ),
                    _ => SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const DiscountListSkeleton(),
                    ),
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
                child: GradientButton(
                  text: t('add_a_discount'),
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.addDiscount),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
