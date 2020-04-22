import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/screen_size_helper.dart';

class MenuButtonFlat extends StatelessWidget {
  final bool isDark;
  final String text;
  final Function onPressed;

  MenuButtonFlat(
      {@required this.text, @required this.isDark, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight(context, dividedBy: 14),
      child: FlatButton(
        child: AutoSizeText(
          text,
          style: Theme.of(context).textTheme.button,
          textAlign: TextAlign.center,
        ),
        color: isDark
            ? Theme.of(context).primaryColorDark
            : Theme.of(context).primaryColor,
        onPressed: onPressed,
      ),
    );
  }
}
