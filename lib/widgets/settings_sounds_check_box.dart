import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/locale/app_localization.dart';
import 'package:provider/provider.dart';

import '../providers/settings.dart';

class SettingsSoundCheckBox extends StatefulWidget {
  SettingsSoundCheckBox({Key key}) : super(key: key);

  @override
  _SettingsSoundCheckBoxState createState() => _SettingsSoundCheckBoxState();
}

class _SettingsSoundCheckBoxState extends State<SettingsSoundCheckBox> {
  @override
  void initState() {
    super.initState();
    _sound = Provider.of<Settings>(context, listen: false).getSoundSetting;
  }

  bool _sound = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: CheckboxListTile(
        activeColor: Theme.of(context).primaryColorDark,
        secondary: Icon(Icons.music_note),
        title: AutoSizeText(
          AppLocalizations.of(context).sound,
          style: Theme.of(context).textTheme.overline,
        ),
        value: _sound,
        onChanged: (bool value) {
          Provider.of<Settings>(context, listen: false).setSoundSettings(value);
          setState(() {
            _sound = value;
          });
        },
      ),
    );
  }
}
