import 'package:flutter/material.dart';

import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/gradient_button.dart';

/// "Validate access"; it slides in once an offer is picked.
class ValidateAccessButton extends StatelessWidget {
  const ValidateAccessButton({
    super.key,
    required this.visible,
    this.onPressed,
  });

  final bool visible;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: visible
          ? GradientButton(
              text: AppLocalization.translateKey(context, 'validate_access'),
              onPressed: onPressed,
            )
          : const SizedBox.shrink(),
    );
  }
}
