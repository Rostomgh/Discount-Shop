import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/theme/colors.dart';

/// One icon of the navigation bar; the selected one is blue on a light blue square.
class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final String icon;

  /// Read by screen readers; the bar shows no text.
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14.r);

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 52.w,
            height: 52.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.chipBackground : Colors.transparent,
              borderRadius: radius,
            ),
            // Unselected icons keep the gray from the SVG files.
            child: SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.w,
              colorFilter: selected
                  ? const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
