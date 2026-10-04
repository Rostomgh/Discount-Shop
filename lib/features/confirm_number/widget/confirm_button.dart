import 'package:flutter/material.dart';

import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/gradient_button.dart';

/// The "Confirm" button; it fades in once the whole code is typed.
class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.visible, this.onPressed});

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
              text: AppLocalization.translateKey(context, 'confirm'),
              onPressed: onPressed,
            )
          : const SizedBox.shrink(),
    );
  }
}
