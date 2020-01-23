import 'package:flutter/material.dart';

import '../widgets/language_picker.dart';
import '../widgets/settings_title_text.dart';

class SettingsPage extends StatelessWidget {
  final List<Widget> settingsWidgets = [
    SettingsTitleText(),
    LanguagePicker(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: 2,
        itemBuilder: (ctx, index) => settingsWidgets[index]);
  }
}
