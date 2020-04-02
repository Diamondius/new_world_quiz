import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/providers/games.dart';
import 'package:new_world_quiz/screens/game_screen.dart';
import 'package:new_world_quiz/widgets/menu_button.dart';
import 'package:provider/provider.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: screenHeight(context, dividedBy: 28),
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: AutoSizeText(
                AppLocalizations.of(context).welcomeTo,
                style: Theme.of(context).textTheme.overline,
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
            ),
            Container(
              height: screenHeight(context, dividedBy: 6),
              width: screenWidth(context, dividedBy: 1.05),
              child: Image.asset(
                "assets/images/title.png",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        MenuButton(
          AppLocalizations.of(context).quickGameButton,
          () {
            Games games = Provider.of<Games>(context, listen: false);
            games.gameType = 0;
            games.newCustomGame(20, 0);
            Navigator.of(context).pushNamed(GameScreen.routeName);
          },
        ),
      ],
    );
  }
}
