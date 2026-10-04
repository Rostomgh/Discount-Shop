import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/status_message.dart';
import '../logic/member_validation_cubit.dart';
import '../widget/member_details.dart';
import '../widget/member_validation_header.dart';
import '../widget/member_validation_skeleton.dart';
import '../widget/validate_access_button.dart';

/// Opened after a member card is scanned or typed: who the member is, and
/// the offer to apply. Pops with true once the access is validated.
class MemberValidationScreen extends StatelessWidget {
  const MemberValidationScreen({super.key, required this.scanned});

  /// The QR code was scanned; false when the number was typed.
  final bool scanned;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MemberValidationCubit>();
    final state = context.watch<MemberValidationCubit>().state;

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
              const MemberValidationHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 16.h),
                  child: switch (state) {
                    MemberValidationLoading() =>
                      const MemberValidationSkeleton(),
                    MemberValidationError() => StatusMessage(
                      icon: Icons.person_off_outlined,
                      title: AppLocalization.translateKey(
                        context,
                        'member_load_error',
                      ),
                      action: TextButton(
                        onPressed: cubit.load,
                        child: Text(
                          AppLocalization.translateKey(context, 'retry'),
                        ),
                      ),
                    ),
                    MemberValidationLoaded(
                      :final member,
                      :final selectedOfferId,
                    ) =>
                      MemberDetails(
                        member: member,
                        scanned: scanned,
                        selectedOfferId: selectedOfferId,
                        onSelectOffer: cubit.selectOffer,
                      ),
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
                child: ValidateAccessButton(
                  visible:
                      state is MemberValidationLoaded &&
                      state.selectedOfferId != null,
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
