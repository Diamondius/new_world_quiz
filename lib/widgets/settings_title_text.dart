import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../locale/app_localization.dart';

class SettingsTitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      AppLocalizations.of(context).settings,
      style: Theme.of(context).textTheme.title,
      textAlign: TextAlign.center,
    );
    ;
  }
}
