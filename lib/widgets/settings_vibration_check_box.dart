import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/locale/app_localization.dart';
import 'package:provider/provider.dart';

import '../providers/settings.dart';

class SettingsVibrationCheckBox extends StatefulWidget {
  SettingsVibrationCheckBox({Key key}) : super(key: key);

  @override
  _SettingsVibrationCheckBoxState createState() =>
      _SettingsVibrationCheckBoxState();
}

class _SettingsVibrationCheckBoxState extends State<SettingsVibrationCheckBox> {
  void initState() {
    super.initState();
    _vibration =
        Provider.of<Settings>(context, listen: false).getVibrationSetting;
  }

  bool _vibration = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: CheckboxListTile(
        activeColor: Theme.of(context).primaryColorDark,
        secondary: Icon(Icons.vibration),
        title: AutoSizeText(
          AppLocalizations.of(context).vibration,
          style: Theme.of(context).textTheme.overline,
        ),
        value: _vibration,
        onChanged: (bool value) {
          Provider.of<Settings>(context, listen: false)
              .setVibrationSettings(value);
          setState(() {
            _vibration = value;
          });
        },
      ),
    );
  }
}
