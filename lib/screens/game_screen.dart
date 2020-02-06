import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/locale/app_localization.dart';
import 'package:new_world_quiz/widgets/game_info_button.dart';
import 'package:new_world_quiz/widgets/game_stats.dart';
import 'package:provider/provider.dart';

import '../helpers/screen_size_helper.dart';
import '../models/question.dart';
import '../providers/games.dart';
import '../providers/questions.dart';
import '../screens/end_of_game_screen.dart';
import '../widgets/divider_question_button.dart';
import '../widgets/page_background.dart';

class GameScreen extends StatefulWidget {
  static const String routeName = "/game";

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Question> _questionList = [];
  Games games;
  String question = "Loading";
  String uploader = "Loading";
  String correctAnswer;
  List<String> buttonText = ["Loading", "Loading", "Loading", "Loading"];
  List<Color> buttonColors = [];
  bool allowReset = true;

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
    if (games.getCurrentRound != games.getNumberOfQuestions) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        allowReset = true;
        games.increaseRound();
        if (answeredText == correctAnswer) {
          games.answeredCorrectly(
              _questionList[games.getCurrentQuestionId].difficulty);
        }
      });
    } else {
      Navigator.of(context).pushReplacementNamed(EndOfGameScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    _questionList = Provider.of<Questions>(context, listen: false).getQuestions;
  }

  @override
  Widget build(BuildContext context) {
    games = Provider.of<Games>(context);
    if (allowReset) {
      int currentQuestionId = games.getCurrentQuestionId;
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
      buttonColors = [
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
      ];
    }
    return Scaffold(
      body: PageBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GameInfoButton(uploader),
                    GameStats(AppLocalizations
                        .of(context)
                        .correct,
                        games.getNumberOfCorrectAnswers),
                    GameStats(AppLocalizations
                        .of(context)
                        .wrong,
                        games.getNumberOfWrongAnswers),
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Theme
                            .of(context)
                            .primaryColorDark,
                        size: screenHeight(context, dividedBy: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: double.infinity,
                  height: screenHeight(context, dividedBy: 3),
                  child: AutoSizeText(question,
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
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
