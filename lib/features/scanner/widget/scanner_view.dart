import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/camera_circle_button.dart';
import '../../../shared/widgets/camera_message.dart';
import 'qr_scan_frame.dart';

/// The dark card with the live camera, the scan frame and the flashlight.
/// The camera only runs while [active] (its tab is shown) and the app is in
/// the foreground; it pauses on the last picture while a card is [found].
class ScannerView extends StatefulWidget {
  const ScannerView({
    super.key,
    required this.active,
    required this.found,
    required this.onDetect,
  });

  final bool active;

  /// A card was found; the frame turns green and the camera pauses.
  final bool found;
  final ValueChanged<String> onDetect;

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> with WidgetsBindingObserver {
  final _controller = MobileScannerController(
    autoStart: false,
    formats: const [BarcodeFormat.qrCode],
  );

  bool _resumed = true;

  // Starting and stopping take time; each waits for the previous one so they
  // don't overlap (the controller throws if started while starting).
  Future<void> _pending = Future.value();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final lifecycle = WidgetsBinding.instance.lifecycleState;
    _resumed = lifecycle == null || lifecycle == AppLifecycleState.resumed;
    _syncCamera();
  }

  @override
  void didUpdateWidget(ScannerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active != oldWidget.active || widget.found != oldWidget.found) {
      _syncCamera();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Release the camera in the background so other apps can use it.
    final resumed = state == AppLifecycleState.resumed;
    if (resumed != _resumed) {
      _resumed = resumed;
      _syncCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_controller.dispose());
    super.dispose();
  }

  void _syncCamera() {
    _pending = _pending.then((_) async {
      if (!mounted) return;
      try {
        if (!widget.active || !_resumed) {
          await _controller.stop();
        } else if (widget.found) {
          // Releases the camera but keeps the last picture on screen.
          await _controller.pause();
        } else {
          await _controller.start();
        }
      } catch (e) {
        // Also catches a missing scanner plugin (widget tests).
        debugPrint('Scanner camera: $e');
      }
    });
  }

  void _onDetect(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      final code = barcode.rawValue;
      if (code != null && code.trim().isNotEmpty) {
        widget.onDetect(code);
        return;
      }
    }
  }

  Widget _error(MobileScannerException error) {
    final denied = error.errorCode == MobileScannerErrorCode.permissionDenied;
    return CameraMessage(
      icon: Icons.no_photography_outlined,
      text: AppLocalization.translateKey(
        context,
        denied ? 'scan_camera_denied' : 'scan_camera_unavailable',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(28.r);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.scannerTop, AppColors.scannerBottom],
            ),
          ),
          child: ValueListenableBuilder<MobileScannerState>(
            valueListenable: _controller,
            builder: (context, camera, _) {
              final error = camera.error;
              return Stack(
                fit: StackFit.expand,
                children: [
                  MobileScanner(
                    controller: _controller,
                    fit: BoxFit.cover,
                    onDetect: _onDetect,
                    // The card's gradient shows until the camera is ready.
                    placeholderBuilder: (_) => const SizedBox.shrink(),
                    errorBuilder: (_, error) => _error(error),
                  ),
                  if (error == null)
                    LayoutBuilder(
                      builder: (context, constraints) => _frame(
                        constraints.biggest,
                        scanning: camera.isRunning,
                      ),
                    ),
                  if (error == null &&
                      (!camera.isInitialized || camera.isStarting))
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  PositionedDirectional(
                    start: 18.w,
                    bottom: 18.w,
                    child: AnimatedScale(
                      scale: camera.torchState == TorchState.unavailable
                          ? 0
                          : 1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutBack,
                      child: CameraCircleButton(
                        icon: camera.torchState == TorchState.on
                            ? Icons.flashlight_on
                            : Icons.flashlight_off_outlined,
                        label: AppLocalization.translateKey(context, 'flash'),
                        onPressed: _controller.toggleTorch,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Dims the camera around the frame, with the frame in the middle.
  Widget _frame(Size size, {required bool scanning}) {
    final side = min(size.width * 0.68, size.height * 0.62);
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: side,
      height: side,
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _DimPainter(hole: rect, radius: 22.r),
        ),
        Positioned.fromRect(
          rect: rect,
          child: QrScanFrame(scanning: scanning, success: widget.found),
        ),
      ],
    );
  }
}

/// Darkens everything except a rounded [hole].
class _DimPainter extends CustomPainter {
  _DimPainter({required this.hole, required this.radius});

  final Rect hole;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || hole.isEmpty) return;
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size)
      ..addRRect(RRect.fromRectAndRadius(hole, Radius.circular(radius)));
    canvas.drawPath(
      path,
      Paint()..color = AppColors.scannerBottom.withValues(alpha: 0.5),
    );
  }

  @override
  bool shouldRepaint(_DimPainter oldDelegate) =>
      oldDelegate.hole != hole || oldDelegate.radius != radius;
}
