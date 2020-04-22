import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../providers/games.dart';
import '../screens/game_screen.dart';
import '../widgets/custom_game_drop_down_button.dart';
import '../widgets/menu_button.dart';
import '../widgets/title_autotext.dart';

//Page that allows the user to create a game with custom settings
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
    _diff = AppLocalizations.of(context).random;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TitleAutoText(AppLocalizations
              .of(context)
              .customGame),
          Container(
            height: screenHeight(context, dividedBy: 2),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(FontAwesomeIcons.question),
                  title: AutoSizeText(
                    AppLocalizations.of(context).questions,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.overline,
                  ),
                  trailing: CustomGameDropDownButton(
                      dropDownButtonType.numberOfQuestions,
                      changeNumberOfQuestions,
                      _numberOfQuestions),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.dumbbell),
                  title: AutoSizeText(
                    AppLocalizations.of(context).difficulty,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.overline,
                  ),
                  trailing: CustomGameDropDownButton(
                      dropDownButtonType.difficulty, changeDifficulty, _diff),
                )
              ],
            ),
          ),
          Consumer<Games>(
            builder: (context, games, child) {
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
                          games.newCustomGame(
                              _numberOfQuestions, _diffPosition);
                          Navigator.of(context).pushNamed(GameScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ]);
  }
}
