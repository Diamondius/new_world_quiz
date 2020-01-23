import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../providers/games.dart';
import '../providers/questions.dart';
import '../screens/game_screen.dart';
import '../widgets/menu_button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: screenHeight(context, dividedBy: 24),
              width: screenWidth(context, dividedBy: 1.90),
              child: AutoSizeText(
                AppLocalizations.of(context).welcomeTo,
                style: Theme.of(context).textTheme.overline,
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
            ),
            Container(
              height: screenHeight(context, dividedBy: 5),
              width: screenWidth(context, dividedBy: 1.05),
              child: AutoSizeText(
                AppLocalizations.of(context).nwQuiz,
                style: Theme.of(context).textTheme.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
            ),
          ],
        ),
        MenuButton(
          AppLocalizations.of(context).quickGameButton,
          () {
            Provider.of<Games>(context, listen: false).newGame(
                Provider.of<Questions>(context, listen: false)
                    .getQuestions
                    .length);
            Navigator.of(context).pushNamed(GameScreen.routeName);
          },
        ),
      ],
    );
  }
}
