import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/helpers/screen_size_helper.dart';
import 'package:new_world_quiz/widgets/custom_game_drop_down_button.dart';
import 'package:provider/provider.dart';

import '../locale/app_localization.dart';
import '../providers/games.dart';
import '../screens/game_screen.dart';
import '../widgets/menu_button.dart';

class CustomGamePage extends StatefulWidget {
  @override
  _CustomGamePageState createState() => _CustomGamePageState();
}

class _CustomGamePageState extends State<CustomGamePage> {
  int _numberOfQuestions = 20;
  String _diff = "Random";
  int _diffPosition = 0;

  void changeNumberOfQuestions(int numberOfQuestions, int value) {
    setState(() {
      _numberOfQuestions = numberOfQuestions;
    });
  }

  void changeDifficulty(int position, String difficulty) {
    setState(() {
      _diff = difficulty;
      _diffPosition = position;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _diff = AppLocalizations
        .of(context)
        .random;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: screenHeight(context, dividedBy: 12),
            child: AutoSizeText(
              AppLocalizations
                  .of(context)
                  .customGame,
              style: Theme
                  .of(context)
                  .textTheme
                  .title,
            ),
          ),
          Container(
            height: screenHeight(context, dividedBy: 2),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: AutoSizeText(
                    AppLocalizations
                        .of(context)
                        .questions,
                    maxLines: 1,
                    style: Theme
                        .of(context)
                        .textTheme
                        .overline,
                  ),
                  trailing: CustomGameDropDownButton(
                      dropDownButtonType.numberOfQuestions,
                      changeNumberOfQuestions,
                      _numberOfQuestions),
                ),
                ListTile(
                  title: AutoSizeText(
                    AppLocalizations
                        .of(context)
                        .difficulty,
                    maxLines: 1,
                    style: Theme
                        .of(context)
                        .textTheme
                        .overline,
                  ),
                  trailing: CustomGameDropDownButton(
                      dropDownButtonType.difficulty, changeDifficulty, _diff),
                )
              ],
            ),
          ),
          Consumer<Games>(builder: (context, games, child) {
            if (games.getGames[0] == null) {
              games.loadGame();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: MenuButton(
                          AppLocalizations
                              .of(context)
                              .continueGame, () {
                        games.gameType = 0;
                        Navigator.of(context).pushNamed(GameScreen.routeName);
                      }, enabled: games.getGames[0] != null),
                    ),
                    MenuButton(
                      AppLocalizations
                          .of(context)
                          .customGame,
                          () {
                        games.gameType = 0;
                        games.newCustomGame(_numberOfQuestions, _diffPosition);
                        Navigator.of(context).pushNamed(GameScreen.routeName);
                      },
                    ),
                  ],
                ),
              ],
            );
          })
        ]);
  }
}
