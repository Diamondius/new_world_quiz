import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_world_quiz/providers/games.dart';
import 'package:new_world_quiz/screens/game_screen.dart';
import 'package:new_world_quiz/widgets/menu_button.dart';
import 'package:provider/provider.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../providers/language.dart';
import '../widgets/custom_game_drop_down_button.dart';
import '../widgets/language_picker.dart';
import '../widgets/overline_autotext.dart';
import '../widgets/page_background.dart';

class OfflineGameScreen extends StatefulWidget {
  static const String routeName = "/offline";

  @override
  _OfflineGameScreenState createState() => _OfflineGameScreenState();
}

class _OfflineGameScreenState extends State<OfflineGameScreen> {
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
    Provider.of<Language>(
        context); //This is so the settings page rebuilds every time the language is changed so the strings update according
    return Scaffold(
      body: PageBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OverLineAutoText(AppLocalizations.of(context).welcomeTo),
                Container(
                  height: screenHeight(context, dividedBy: 6),
                  width: screenWidth(context, dividedBy: 1.05),
                  child: Image.asset(
                    "assets/images/title.png",
                    fit: BoxFit.contain,
                  ),
                ),
                OverLineAutoText(AppLocalizations.of(context).offline),
                IconButton(
                  icon: Icon(FontAwesomeIcons.signInAlt),
                  color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  iconSize: screenHeight(context, dividedBy: 20),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 40),
                ),
                LanguagePicker(),
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
                ),
              ],
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
                              AppLocalizations.of(context).continueGame, () {
                            games.gameType = 0;
                            Navigator.of(context)
                                .pushNamed(GameScreen.routeName);
                          }, enabled: games.getGames[0] != null),
                        ),
                        MenuButton(
                          AppLocalizations.of(context).customGame,
                          () {
                            games.gameType = 0;
                            games.newCustomGame(
                                _numberOfQuestions, _diffPosition);
                            Navigator.of(context)
                                .pushNamed(GameScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
