import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';

/// The square that shows where to put the product, with thick corners.
/// Shrinks if the camera area is too short.
class ScanFrame extends StatelessWidget {
  const ScanFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 218.w, maxHeight: 218.w),
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(painter: _ScanFramePainter(radius: 16.r)),
      ),
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  _ScanFramePainter({required this.radius});

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    // Empty on a first frame drawn before the screen has a size.
    if (size.isEmpty) return;

    final w = size.width;
    final h = size.height;
    final r = min(radius, size.shortestSide / 4);
    final corner = Radius.circular(r);

    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, corner),
      Paint()
        ..color = AppColors.white.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final len = max(size.shortestSide * 0.16, r);
    final corners = Path()
      ..moveTo(0, len)
      ..lineTo(0, r)
      ..arcToPoint(Offset(r, 0), radius: corner)
      ..lineTo(len, 0)
      ..moveTo(w - len, 0)
      ..lineTo(w - r, 0)
      ..arcToPoint(Offset(w, r), radius: corner)
      ..lineTo(w, len)
      ..moveTo(w, h - len)
      ..lineTo(w, h - r)
      ..arcToPoint(Offset(w - r, h), radius: corner)
      ..lineTo(w - len, h)
      ..moveTo(len, h)
      ..lineTo(r, h)
      ..arcToPoint(Offset(0, h - r), radius: corner)
      ..lineTo(0, h - len);
    canvas.drawPath(
      corners,
      Paint()
        ..color = AppColors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawCircle(
      size.center(Offset.zero),
      4,
      Paint()..color = AppColors.white,
    );
  }

  @override
  bool shouldRepaint(_ScanFramePainter oldDelegate) =>
      oldDelegate.radius != radius;
}
