import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../locale/app_localization.dart';
import '../widgets/language_picker.dart';
import '../widgets/settings_sounds_check_box.dart';
import '../widgets/settings_vibration_check_box.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AutoSizeText(
        AppLocalizations
            .of(context)
            .settings,
        style: Theme
            .of(context)
            .textTheme
            .title,
        textAlign: TextAlign.center,
      ),
      LanguagePicker(),
      SettingsSoundCheckBox(),
      SettingsVibrationCheckBox(),
    ]);
  }
}
