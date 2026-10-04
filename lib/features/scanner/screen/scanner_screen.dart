import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../logic/scanner_cubit.dart';
import '../widget/manual_entry_sheet.dart';
import '../widget/scanner_title.dart';
import '../widget/scanner_view.dart';

/// Third tab of the navigation bar: scan a member's QR card, or type its
/// number. The camera only runs while [active] (the tab is shown).
class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key, required this.active});

  final bool active;

  /// Opens the member, then scans again when the partner comes back.
  Future<void> _showMember(
    BuildContext context,
    String code, {
    required bool scanned,
  }) async {
    HapticFeedback.mediumImpact();
    final cubit = context.read<ScannerCubit>();
    // Lets the frame turn green before the page covers it.
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (!context.mounted) return;
    final validated = await Navigator.pushNamed<bool>(
      context,
      Routes.memberValidation,
      arguments: (code: code, scanned: scanned),
    );
    if (validated == true && context.mounted) {
      showToast(
        context,
        AppLocalization.translateKey(context, 'access_validated'),
      );
    }
    cubit.scanAgain();
  }

  Future<void> _manualEntry(BuildContext context) async {
    final cubit = context.read<ScannerCubit>();
    final code = await ManualEntrySheet.show(context);
    if (code != null) cubit.cardFound(code, scanned: false);
  }

  @override
  Widget build(BuildContext context) {
    final found = context.select(
      (ScannerCubit cubit) => cubit.state is ScannerFound,
    );

    return BlocListener<ScannerCubit, ScannerState>(
      listener: (context, state) {
        if (state case ScannerFound(:final code, :final scanned)) {
          _showMember(context, code, scanned: scanned);
        }
      },
      child: ColoredBox(
        color: AppColors.background,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              const ScannerTitle(),
              SizedBox(height: 24.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: FadeSlideIn(
                    delay: const Duration(milliseconds: 80),
                    child: ScannerView(
                      active: active,
                      found: found,
                      onDetect: context.read<ScannerCubit>().cardFound,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: FadeSlideIn(
                  delay: const Duration(milliseconds: 160),
                  child: GradientButton(
                    text: AppLocalization.translateKey(context, 'manual_entry'),
                    onPressed: () => _manualEntry(context),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
