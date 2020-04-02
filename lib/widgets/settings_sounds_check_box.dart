import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locale/app_localization.dart';
import '../providers/settings.dart';

//Class for the check box widget for the sounds settings
class SettingsSoundCheckBox extends StatefulWidget {
  SettingsSoundCheckBox({Key key}) : super(key: key);

  @override
  _SettingsSoundCheckBoxState createState() => _SettingsSoundCheckBoxState();
}

class _SettingsSoundCheckBoxState extends State<SettingsSoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Consumer(
          builder: (BuildContext context, Settings settings, Widget child) {
        return CheckboxListTile(
          activeColor: Theme.of(context).primaryColorDark,
          secondary: Icon(Icons.music_note),
          title: AutoSizeText(
            AppLocalizations.of(context).sound,
            style: Theme.of(context).textTheme.overline,
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
          value: settings.getSoundSetting,
          onChanged: (bool value) {
            Provider.of<Settings>(context, listen: false)
                .setSoundSettings(value);
            setState(() {
              settings.setSoundSettings(value);
            });
          },
        );
      }),
    );
  }
}
