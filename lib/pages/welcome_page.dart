import 'package:flutter/material.dart';
import 'package:new_world_quiz/models/user.dart';
import 'package:new_world_quiz/providers/games.dart';
import 'package:new_world_quiz/screens/game_screen.dart';
import 'package:new_world_quiz/widgets/menu_button.dart';
import 'package:new_world_quiz/widgets/overline_autotext.dart';
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
            OverLineAutoText(AppLocalizations
                .of(context)
                .welcomeTo),
            Container(
              height: screenHeight(context, dividedBy: 6),
              width: screenWidth(context, dividedBy: 1.05),
              padding: EdgeInsets.only(
                bottom: screenHeight(context, dividedBy: 80),
              ),
              child: Image.asset(
                "assets/images/title.png",
                fit: BoxFit.contain,
              ),
            ),
            OverLineAutoText(
                Provider
                    .of<User>(context, listen: false)
                    .userName),
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
