import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/screen_size_helper.dart';

//An image with a text on top that shows a specific stat of the  game like correct answers or wrong answers
class GameStats extends StatelessWidget {
  final String questionStatType;
  final int stat;

  GameStats(this.questionStatType, this.stat);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: screenHeight(context,
              dividedBy: 150)), //Icons do not seem very much aligned otherwise
      height: screenHeight(context, dividedBy: 20),
      width: screenWidth(context, dividedBy: 2.9),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "assets/images/scroll.png",
            fit: BoxFit.fill,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 35),
            ),
            alignment: Alignment.center,
            child: AutoSizeText(
              "$questionStatType: $stat",
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.left,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
