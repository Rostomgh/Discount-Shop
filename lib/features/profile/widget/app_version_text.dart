import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../core/extensions/bidi.dart';
import '../../../shared/utils/localization/app_ localization.dart';

/// "App Version 1.0.0 (Build 1)", from the version in pubspec.yaml.
class AppVersionText extends StatefulWidget {
  const AppVersionText({super.key});

  @override
  State<AppVersionText> createState() => _AppVersionTextState();
}

class _AppVersionTextState extends State<AppVersionText> {
  // Stays empty if the version can't be read (e.g. after a hot restart that
  // added the plugin; a full rebuild is needed).
  late final Future<PackageInfo?> _info = PackageInfo.fromPlatform()
      .then<PackageInfo?>((info) => info)
      .catchError((Object e) {
        debugPrint('Reading the app version failed: $e');
        return null;
      });

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return FutureBuilder<PackageInfo?>(
      future: _info,
      builder: (context, snapshot) {
        final info = snapshot.data;
        return AnimatedOpacity(
          opacity: info == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: Text(
            info == null
                ? ''
                : '${t('app_version')} ${info.version.ltrIsolated} '
                      '(${t('build')} ${info.buildNumber.ltrIsolated})',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.icon,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
