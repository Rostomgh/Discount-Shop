import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/localization/app_ localization.dart';
import '../logic/add_product_cubit.dart';
import 'add_tag_button.dart';
import 'tag_chip.dart';

/// Suggested tags; tapping one selects or unselects it.
class QuickTags extends StatelessWidget {
  const QuickTags({super.key, this.onAddTag});

  final VoidCallback? onAddTag;

  @override
  Widget build(BuildContext context) {
    final selected = context.select((AddProductCubit c) => c.state.tags);

    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final key in AddProductCubit.quickTags)
          TagChip(
            label: AppLocalization.translateKey(context, key),
            selected: selected.contains(key),
            onTap: () => context.read<AddProductCubit>().toggleTag(key),
          ),
        AddTagButton(onPressed: onAddTag),
      ],
    );
  }
}
