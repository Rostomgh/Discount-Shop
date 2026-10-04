import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/theme/colors.dart';

/// Blue area with a faint grid (login screen, home header).
class GridBackground extends StatelessWidget {
  const GridBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary,
      child: CustomPaint(
        painter: _GridPainter(spacing: 50.w),
        size: Size.infinite,
        child: child,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.spacing});

  final double spacing;

  @override
  void paint(Canvas canvas, Size size) {
    // ScreenUtil values are 0 on a first frame drawn before the screen has a
    // size; a 0 spacing would make the loops below run forever.
    if (spacing <= 0) return;

    final paint = Paint()
      ..color = AppColors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    // Vertical lines are centered on the screen like in the design.
    final center = size.width / 2;
    for (var x = center % spacing; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) =>
      oldDelegate.spacing != spacing;
}
