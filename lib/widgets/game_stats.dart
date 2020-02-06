import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/helpers/screen_size_helper.dart';

class GameStats extends StatelessWidget {
  final String questionStatType;
  final int stat;

  GameStats(this.questionStatType, this.stat);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight(context, dividedBy: 150)),
      height: screenHeight(context, dividedBy: 20),
      width: screenWidth(context, dividedBy: 3.3),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "assets/images/scroll.png",
            fit: BoxFit.fill,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
            alignment: Alignment.center,
            child: AutoSizeText(
              "$questionStatType: $stat",
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
