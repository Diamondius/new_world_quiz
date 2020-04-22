import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/helpers/screen_size_helper.dart';

class TitleAutoText extends StatelessWidget {
  final String _text;

  TitleAutoText(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context, dividedBy: 11),
      child: AutoSizeText(
        _text,
        style: Theme.of(context).textTheme.title,
        maxLines: 1,
        overflow: TextOverflow.fade,
        textAlign: TextAlign.center,
      ),
    );
  }
}
