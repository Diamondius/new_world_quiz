import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/providers/settings.dart';
import 'package:provider/provider.dart';
import 'package:vibrate/vibrate.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../models/game.dart';
import '../models/question.dart';
import '../providers/games.dart';
import '../providers/questions.dart';
import '../screens/end_of_game_screen.dart';
import '../widgets/divider_question_button.dart';
import '../widgets/game_info_button.dart';
import '../widgets/game_stats.dart';
import '../widgets/page_background.dart';

class GameScreen extends StatefulWidget {
  static const String routeName = "/game";

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Question> _questionList = [];
  Game game;
  Games games;
  String question = "Loading";
  String uploader = "Loading";
  String source = "Loading";
  String correctAnswer;
  List<String> buttonText = ["Loading", "Loading", "Loading", "Loading"];
  List<Color> buttonColors = [];
  bool allowReset = true;
  bool sounds = true;
  bool vibrate = true;

  void buttonPressed(String answeredText, int id) {
    setState(() {
      allowReset = false;
      for (int i = 0; i < buttonText.length; i++) {
        if (buttonText[i] == correctAnswer) {
          buttonColors[i] = Colors.green;
        }
        if (answeredText != correctAnswer) {
          buttonColors[id] = Colors.red;
        }
      }
    });
    if (game.getRoundNumber != game.getNumberOfQuestions) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        allowReset = true;
        games.increaseRound();
        if (answeredText == correctAnswer) {
          if (sounds) playLocalAsset("sounds/correct.mp3");
          game.answeredCorrectly(
              _questionList[game.getCurrentQuestionId].difficulty);
        } else {
          if (sounds) playLocalAsset("sounds/wrong.mp3");
          if (vibrate) Vibrate.vibrate();
        }
        if (game.roundNumber < game.numberOfQuestions) {
          games.saveCurrentGame();
        }
      });
    } else {
      Navigator.of(context).pushReplacementNamed(EndOfGameScreen.routeName);
    }
  }

  //AudioPlayer for correct and wrong sounds
  Future<AudioPlayer> playLocalAsset(String soundFile) async {
    if (sounds) {
      AudioCache cache = new AudioCache();
      return await cache.play(soundFile);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _questionList = Provider.of<Questions>(context, listen: false).getQuestions;
    var settings = Provider.of<Settings>(context, listen: false);
    sounds = settings.getSoundSetting;
    vibrate = settings.getVibrationSetting;
  }

  @override
  Widget build(BuildContext context) {
    games = Provider.of<Games>(context);
    game = games.getGame;
    if (allowReset) {
      int currentQuestionId = game.getCurrentQuestionId;
      buttonText = [
        _questionList[currentQuestionId].correctAnswer,
        _questionList[currentQuestionId].wrongAnswer1,
        _questionList[currentQuestionId].wrongAnswer2,
        _questionList[currentQuestionId].wrongAnswer3,
      ];
      buttonText.shuffle();
      question = _questionList[currentQuestionId].question;
      correctAnswer = _questionList[currentQuestionId].correctAnswer;
      uploader = _questionList[currentQuestionId].uploader;
      source = _questionList[currentQuestionId].source;
      print(
          "Id: ${currentQuestionId
              .toString()} Difficulty:${_questionList[currentQuestionId]
              .difficulty
              .toString()} Secondary id: ${_questionList[currentQuestionId]
              .id}");
      buttonColors = [
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
      ];
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          screenHeight(context, dividedBy: 13),
        ),
        child: Container(
          color: Theme
              .of(context)
              .primaryColorDark,
          padding: EdgeInsets.only(
              top: screenHeightToolbar(context, increasedBy: 4), bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GameInfoButton(uploader, source),
              GameStats(AppLocalizations
                  .of(context)
                  .correct,
                  game.getNumberOfCorrectAnswers),
              GameStats(AppLocalizations
                  .of(context)
                  .wrong,
                  game.getNumberOfWrongAnswers),
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme
                      .of(context)
                      .primaryColorLight,
                  size: screenHeight(context, dividedBy: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
      body: PageBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(0),
                  width: double.infinity,
                  height: screenHeight(context, dividedBy: 3),
                  child: AutoSizeText(question,
                      style: Theme
                          .of(context)
                          .textTheme
                          .overline,
                      textAlign: TextAlign.center),
                  alignment: Alignment.topCenter,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme
                        .of(context)
                        .primaryColorDark, width: 5),
                borderRadius: BorderRadius.all(
                  const Radius.circular(5),
                ),
              ),
              child: AbsorbPointer(
                absorbing: !allowReset,
                child: Column(
                  children: <Widget>[
                    answerFlatButton(
                      buttonText[0],
                      buttonColors[0],
                          () {
                        buttonPressed(buttonText[0], 0);
                      },
                    ),
                    DividerQuestionButton(),
                    answerFlatButton(
                      buttonText[1],
                      buttonColors[1],
                          () {
                        buttonPressed(buttonText[1], 1);
                      },
                    ),
                    DividerQuestionButton(),
                    answerFlatButton(
                      buttonText[2],
                      buttonColors[2],
                          () {
                        buttonPressed(buttonText[2], 2);
                      },
                    ),
                    DividerQuestionButton(),
                    answerFlatButton(
                      buttonText[3],
                      buttonColors[3],
                          () {
                        buttonPressed(buttonText[3], 3);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container answerFlatButton(String text, Color color, Function onPressed) {
    return Container(
      decoration: BoxDecoration(color: color),
      height: screenHeight(context, dividedBy: 10.0),
      width: double.infinity,
      child: FlatButton(
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
