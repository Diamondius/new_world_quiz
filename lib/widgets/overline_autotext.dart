import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/screen_size_helper.dart';

class OverLineAutoText extends StatelessWidget {
  final String _text;

  OverLineAutoText(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context, dividedBy: 22),
      alignment: Alignment.center,
      child: AutoSizeText(
        _text,
        style: Theme.of(context).textTheme.overline,
        textAlign: TextAlign.center,
        textScaleFactor: 1.5,
      ),
    );
  }
}
