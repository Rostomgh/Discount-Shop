import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';

/// The product photo, or a bag icon when there's none.
class ProductImage extends StatelessWidget {
  const ProductImage({super.key, this.path, required this.size});

  final String? path;
  final double size;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: size,
      height: size,
      color: AppColors.chipBackground,
      child: Icon(
        Icons.shopping_bag_outlined,
        color: AppColors.primary,
        size: size * 0.42,
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: path == null
          ? placeholder
          : Image.file(
              File(path!),
              width: size,
              height: size,
              fit: BoxFit.cover,
              // A photo from an earlier run may have been cleaned up.
              errorBuilder: (_, _, _) => placeholder,
            ),
    );
  }
}
