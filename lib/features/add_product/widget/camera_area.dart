import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/camera_circle_button.dart';
import '../../../shared/widgets/camera_message.dart';
import '../logic/add_product_cubit.dart';
import 'camera_top_bar.dart';
import 'capture_button.dart';
import 'retake_button.dart';
import 'scan_frame.dart';

/// Top of the add product screen: the live camera, or the photo once it's
/// taken or picked, with the camera buttons on top.
class CameraArea extends StatefulWidget {
  const CameraArea({super.key});

  @override
  State<CameraArea> createState() => _CameraAreaState();
}

enum _CameraProblem { denied, unavailable }

const _deniedCodes = {
  'CameraAccessDenied',
  'CameraAccessDeniedWithoutPrompt',
  'CameraAccessRestricted',
};

class _CameraAreaState extends State<CameraArea>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  CameraController? _controller;
  _CameraProblem? _problem;
  bool _starting = false;

  // White flash when a photo is taken; at rest (value 1) it's invisible.
  late final _shutter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
    value: 1,
  );

  bool get _wantsCamera =>
      mounted && context.read<AddProductCubit>().state.imagePath == null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (_wantsCamera) _startCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    _shutter.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Release the camera in the background so other apps can use it.
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed && _wantsCamera) {
      _startCamera();
    }
  }

  Future<void> _startCamera() async {
    if (_starting || _controller != null) return;
    _starting = true;
    CameraController? controller;
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) throw CameraException('NoCamera', null);
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await controller.initialize();
      if (!_wantsCamera) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _problem = null;
      });
    } catch (e) {
      // Also catches a missing camera plugin (widget tests).
      debugPrint('Camera not available: $e');
      await controller?.dispose();
      if (mounted) {
        final denied = e is CameraException && _deniedCodes.contains(e.code);
        setState(() {
          _problem = denied
              ? _CameraProblem.denied
              : _CameraProblem.unavailable;
        });
      }
    } finally {
      _starting = false;
    }
  }

  void _stopCamera() {
    final controller = _controller;
    if (controller == null) return;
    _controller = null;
    controller.dispose();
    if (mounted) setState(() {});
  }

  Future<void> _takePhoto() async {
    final controller = _controller;
    if (controller == null ||
        !controller.value.isInitialized ||
        controller.value.isTakingPicture) {
      return;
    }
    final cubit = context.read<AddProductCubit>();
    try {
      await controller.setFlashMode(
        cubit.state.flashOn ? FlashMode.always : FlashMode.off,
      );
    } catch (_) {
      // Not every camera has a flash (the emulator doesn't).
    }
    try {
      _shutter.forward(from: 0);
      final photo = await controller.takePicture();
      cubit.setImage(photo.path);
    } catch (e) {
      debugPrint('Taking the photo failed: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    final cubit = context.read<AddProductCubit>();
    final path = await pickGalleryImage();
    if (path != null) cubit.setImage(path);
  }

  Widget _background(String? imagePath) {
    final controller = _controller;
    if (imagePath != null) {
      return Image.file(
        File(imagePath),
        key: ValueKey(imagePath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (_problem != null) {
      return CameraMessage(
        key: ValueKey(_problem),
        icon: Icons.no_photography_outlined,
        text: AppLocalization.translateKey(
          context,
          _problem == _CameraProblem.denied
              ? 'camera_denied'
              : 'camera_unavailable',
        ),
      );
    }
    if (controller == null || !controller.value.isInitialized) {
      return const Center(
        key: ValueKey('loading'),
        child: CircularProgressIndicator(
          color: AppColors.white,
          strokeWidth: 2,
        ),
      );
    }
    // previewSize is landscape; swap it so the preview fills the area
    // without stretching.
    final size = controller.value.previewSize;
    return ClipRect(
      key: const ValueKey('preview'),
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: size?.height ?? 1,
          height: size?.width ?? 1,
          child: CameraPreview(controller),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddProductCubit>().state;
    final cubit = context.read<AddProductCubit>();
    final hasPhoto = state.imagePath != null;
    final showFrame = !hasPhoto && _problem == null;

    return BlocListener<AddProductCubit, AddProductState>(
      listenWhen: (a, b) => a.imagePath != b.imagePath,
      listener: (_, state) =>
          state.imagePath == null ? _startCamera() : _stopCamera(),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // Reaches under the rounded top corners of the product sheet.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: -40.h,
            child: ColoredBox(
              color: AppColors.cameraBackground,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                // Fill the area; the default layout lets the preview shrink
                // to its own aspect ratio.
                layoutBuilder: (current, previous) => Stack(
                  fit: StackFit.expand,
                  children: [...previous, if (current != null) current],
                ),
                child: _background(state.imagePath),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: FadeTransition(
                opacity: ReverseAnimation(_shutter),
                child: const ColoredBox(color: AppColors.white),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 14.h),
              child: Column(
                children: [
                  CameraTopBar(
                    flashOn: state.flashOn,
                    showFlash: !hasPhoto,
                    onClose: () => Navigator.maybePop(context),
                    onFlash: cubit.toggleFlash,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: AnimatedOpacity(
                          opacity: showFrame ? 1 : 0,
                          duration: const Duration(milliseconds: 250),
                          child: const ScanFrame(),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: CameraCircleButton(
                            icon: Icons.photo_library_outlined,
                            label: AppLocalization.translateKey(
                              context,
                              'import_gallery',
                            ),
                            onPressed: _pickFromGallery,
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(
                              scale: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            ),
                        child: hasPhoto
                            ? RetakeButton(
                                key: const ValueKey('retake'),
                                onPressed: cubit.clearImage,
                              )
                            : CaptureButton(
                                key: const ValueKey('capture'),
                                onPressed: _controller == null
                                    ? null
                                    : _takePhoto,
                              ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
