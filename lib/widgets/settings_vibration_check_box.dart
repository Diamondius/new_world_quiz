import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locale/app_localization.dart';
import '../providers/settings.dart';

//Check box widget that controls vibration
class SettingsVibrationCheckBox extends StatefulWidget {
  SettingsVibrationCheckBox({Key key}) : super(key: key);

  @override
  _SettingsVibrationCheckBoxState createState() =>
      _SettingsVibrationCheckBoxState();
}

class _SettingsVibrationCheckBoxState extends State<SettingsVibrationCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Consumer<Settings>(
        builder: (BuildContext context, Settings settings, Widget child) {
          return CheckboxListTile(
            activeColor: Theme
                .of(context)
                .primaryColorDark,
            secondary: Icon(Icons.vibration),
            title: AutoSizeText(
              AppLocalizations
                  .of(context)
                  .vibration,
              style: Theme
                  .of(context)
                  .textTheme
                  .overline,
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
            value: settings.getVibrationSetting,
            onChanged: (bool value) {
              Provider.of<Settings>(context, listen: false)
                  .setVibrationSettings(value);
              setState(() {
                settings.setVibrationSettings(value);
              });
            },
          );
        },
      ),
    );
  }
}
