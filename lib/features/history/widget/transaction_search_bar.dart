import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../logic/history_cubit.dart';
import 'mic_button.dart';

/// Search field (filters the list while typing) and the microphone button.
class TransactionSearchBar extends StatefulWidget {
  const TransactionSearchBar({super.key});

  @override
  State<TransactionSearchBar> createState() => _TransactionSearchBarState();
}

class _TransactionSearchBarState extends State<TransactionSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {}); // shows or hides the clear button
    context.read<HistoryCubit>().search(query);
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final textStyle = TextStyle(color: AppColors.textPrimary, fontSize: 15.sp);
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.r),
      borderSide: BorderSide(color: color),
    );

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onChanged: _search,
            textInputAction: TextInputAction.search,
            style: textStyle,
            decoration: InputDecoration(
              hintText: t('search_transactions'),
              hintStyle: textStyle.copyWith(color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.white,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textMuted,
                size: 22.w,
              ),
              suffixIcon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: _controller.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        tooltip: t('clear_search'),
                        icon: Icon(
                          Icons.close,
                          color: AppColors.textMuted,
                          size: 20.w,
                        ),
                        onPressed: () {
                          _controller.clear();
                          _search('');
                        },
                      ),
              ),
              enabledBorder: border(AppColors.border),
              focusedBorder: border(AppColors.primary),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        MicButton(
          // TODO: voice search needs a speech-to-text package.
          onPressed: () => showToast(
            context,
            t('voice_search_soon'),
            type: ToastificationType.info,
          ),
        ),
      ],
    );
  }
}
