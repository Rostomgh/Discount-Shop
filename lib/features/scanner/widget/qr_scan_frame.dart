import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';

/// Glowing corners that show where to hold the QR code. While [scanning], a
/// light beam sweeps up and down; when [success], the corners turn green and
/// pop.
class QrScanFrame extends StatefulWidget {
  const QrScanFrame({super.key, required this.scanning, required this.success});

  final bool scanning;
  final bool success;

  @override
  State<QrScanFrame> createState() => _QrScanFrameState();
}

class _QrScanFrameState extends State<QrScanFrame>
    with TickerProviderStateMixin {
  late final _sweep = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  );

  late final _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
    reverseDuration: const Duration(milliseconds: 250),
  );

  bool get _sweeping => widget.scanning && !widget.success;

  @override
  void initState() {
    super.initState();
    if (_sweeping) _sweep.repeat(reverse: true);
    if (widget.success) _pop.value = 1;
  }

  @override
  void didUpdateWidget(QrScanFrame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_sweeping && !_sweep.isAnimating) {
      _sweep.repeat(reverse: true);
    } else if (!_sweeping && _sweep.isAnimating) {
      _sweep.stop();
    }
    if (widget.success != oldWidget.success) {
      widget.success ? _pop.forward(from: 0) : _pop.reverse();
    }
  }

  @override
  void dispose() {
    _sweep.dispose();
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pop,
      // Grows a little and comes back, like a heartbeat.
      builder: (context, child) =>
          Transform.scale(scale: 1 + 0.07 * sin(pi * _pop.value), child: child),
      child: CustomPaint(
        painter: _FramePainter(
          sweep: _sweep,
          pop: _pop,
          radius: 22.r,
          showBeam: _sweeping,
        ),
      ),
    );
  }
}

class _FramePainter extends CustomPainter {
  _FramePainter({
    required this.sweep,
    required this.pop,
    required this.radius,
    required this.showBeam,
  }) : super(repaint: Listenable.merge([sweep, pop]));

  final AnimationController sweep;
  final Animation<double> pop;
  final double radius;
  final bool showBeam;

  @override
  void paint(Canvas canvas, Size size) {
    // Empty on a first frame drawn before the screen has a size.
    if (size.isEmpty) return;

    final w = size.width;
    final h = size.height;
    final r = min(radius, size.shortestSide / 4);
    final corner = Radius.circular(r);
    final frame = RRect.fromRectAndRadius(Offset.zero & size, corner);
    final color = Color.lerp(
      AppColors.primaryLight,
      AppColors.success,
      pop.value,
    )!;

    // Faint blue light inside the frame.
    canvas.drawRRect(
      frame,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.16),
            color.withValues(alpha: 0.04),
          ],
        ).createShader(Offset.zero & size),
    );

    if (showBeam) _paintBeam(canvas, size, color);

    final len = max(size.shortestSide * 0.2, r);
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

    // The glow breathes with the beam: brightest when it crosses the middle.
    final glow = 0.45 + 0.35 * sin(pi * sweep.value) + 0.2 * pop.value;
    canvas.drawPath(
      corners,
      Paint()
        ..color = color.withValues(alpha: glow.clamp(0, 1))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    canvas.drawPath(
      corners,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );
  }

  /// A bright line with a fading trail behind it.
  void _paintBeam(Canvas canvas, Size size, Color color) {
    final inset = size.height * 0.06;
    final t = Curves.easeInOut.transform(sweep.value);
    final y = inset + (size.height - 2 * inset) * t;
    final trail = size.height * 0.22;
    final goingDown = sweep.status != AnimationStatus.reverse;

    final trailRect = goingDown
        ? Rect.fromLTRB(0, max(0, y - trail), size.width, y)
        : Rect.fromLTRB(0, y, size.width, min(size.height, y + trail));
    if (!trailRect.isEmpty) {
      canvas.drawRect(
        trailRect,
        Paint()
          ..shader = LinearGradient(
            begin: goingDown ? Alignment.topCenter : Alignment.bottomCenter,
            end: goingDown ? Alignment.bottomCenter : Alignment.topCenter,
            colors: [color.withValues(alpha: 0), color.withValues(alpha: 0.28)],
          ).createShader(trailRect),
      );
    }

    final lineRect = Rect.fromLTRB(
      size.width * 0.04,
      y - 1.5,
      size.width * 0.96,
      y + 1.5,
    );
    final lineShader = LinearGradient(
      colors: [
        color.withValues(alpha: 0),
        AppColors.white,
        color.withValues(alpha: 0),
      ],
    ).createShader(lineRect);
    canvas.drawRect(
      lineRect.inflate(3),
      Paint()
        ..shader = lineShader
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawRect(lineRect, Paint()..shader = lineShader);
  }

  @override
  bool shouldRepaint(_FramePainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.showBeam != showBeam;
}
