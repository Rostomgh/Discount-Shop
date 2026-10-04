import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// Round "+" button with a dashed border, after the tags.
class AddTagButton extends StatelessWidget {
  const AddTagButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: AppLocalization.translateKey(context, 'add_tag'),
      child: Material(
        type: MaterialType.transparency,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: CustomPaint(
            painter: _DashedCirclePainter(),
            child: SizedBox.square(
              dimension: 46.w,
              child: Icon(Icons.add, color: AppColors.hint, size: 22.w),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  // A fixed number of dashes, not a ScreenUtil step: ScreenUtil values are 0
  // on the first frame and a 0 step would loop forever.
  static const _dashCount = 14;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final paint = Paint()
      ..color = AppColors.hint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final rect = (Offset.zero & size).deflate(0.6);
    const sweep = 2 * pi / _dashCount;
    for (var i = 0; i < _dashCount; i++) {
      canvas.drawArc(rect, i * sweep, sweep / 2, false, paint);
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter oldDelegate) => false;
}
