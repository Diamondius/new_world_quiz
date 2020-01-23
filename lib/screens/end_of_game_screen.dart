import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../providers/games.dart';
import '../widgets/menu_button.dart';
import '../widgets/page_background.dart';

class EndOfGameScreen extends StatelessWidget {
  static const routeName = "/endOfGame";

  @override
  Widget build(BuildContext context) {
    Games game = Provider.of<Games>(context, listen: false);
    String evaluationText;
    String exclamation;
    if (game.getNumberOfQuestions == game.getNumberOfCorrectAnswers) {
      exclamation = AppLocalizations.of(context).exclamationPerfect;
      evaluationText = AppLocalizations.of(context).evaluationPerfect;
    } else if (game.getNumberOfCorrectAnswers >
        3 * (game.getNumberOfQuestions / 4)) {
      exclamation = AppLocalizations.of(context).exclamationGreat;
      evaluationText = AppLocalizations.of(context).evaluationGreat;
    } else if (game.getNumberOfCorrectAnswers <=
            3 * (game.getNumberOfQuestions / 4) &&
        game.getNumberOfCorrectAnswers > game.getNumberOfQuestions / 2) {
      exclamation = AppLocalizations.of(context).exclamationGood;
      evaluationText = AppLocalizations.of(context).evaluationGood;
    } else {
      exclamation = AppLocalizations.of(context).exclamationThank;
      evaluationText = AppLocalizations.of(context).evaluationThank;
    }
    return Scaffold(
      body: PageBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: screenHeight(context, dividedBy: 7),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    exclamation,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: screenHeight(context, dividedBy: 7),
                  child: AutoSizeText(
                    evaluationText,
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  height: screenHeight(context, dividedBy: 15),
                  child: AutoSizeText(
                    AppLocalizations.of(context).inDepth,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: screenHeight(context, dividedBy: 30),
                  child: AutoSizeText(
                    "${AppLocalizations.of(context).correctAnswers}: ${game.getNumberOfCorrectAnswers} / ${game.getNumberOfQuestions}",
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: screenHeight(context, dividedBy: 30),
                  child: AutoSizeText(
                      "${AppLocalizations.of(context).totalPoints}: ${game.getPoints}",
                      style: Theme.of(context).textTheme.overline),
                ),
              ],
            ),
            MenuButton(AppLocalizations.of(context).buttonEndGame, () {
              Navigator.of(context).pop();
            })
          ],
        ),
      ),
    );
  }
}
