import 'package:flutter/material.dart';

import '../../../shared/utils/localization/app_ localization.dart';
import '../widget/language_menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.translateKey(context, 'app_name')),
        actions: const [LanguageMenuButton()],
      ),
    );
  }
}
