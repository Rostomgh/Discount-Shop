import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

/// Lets the user choose a photo from the gallery. Returns its file path, or
/// null if they cancel or the gallery can't be opened.
Future<String?> pickGalleryImage() async {
  try {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 85,
    );
    return file?.path;
  } on PlatformException catch (e) {
    debugPrint('Gallery not available: $e');
    return null;
  }
}

void showToast(
  BuildContext context,
  String message, {
  ToastificationType type = ToastificationType.success,
}) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flatColored,
    title: Text(message),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
  );
}
