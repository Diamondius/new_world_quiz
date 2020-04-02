import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/providers/settings.dart';
import 'package:new_world_quiz/widgets/single_touch_recognizer_widget.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

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
  List<Question> _questionList = []; //List of question objects
  Game _game; //Game object
  Games _games; //Games provider object
  String _question = "Loading";
  String _uploader = "Loading";
  String _source = "Loading";
  String _correctAnswer;
  List<String> _buttonText = ["Loading", "Loading", "Loading", "Loading"];
  List<Color> _buttonColors = [];
  bool _allowReset = true;
  bool _sounds = true;
  bool _vibrate = true;

  void buttonPressed(String answeredText, int id) {
    setState(() {
      _allowReset = false; //stop button changes on rebuild
      for (int i = 0; i < _buttonText.length; i++) {
        //Change correct answer to green and if wrong pressed to red
        if (_buttonText[i] == _correctAnswer) _buttonColors[i] = Colors.green;
        if (answeredText != _correctAnswer) _buttonColors[id] = Colors.red;
      }
    });
    if (_game.getRoundNumber != _game.getNumberOfQuestions) {
      //If game not finished
      Future.delayed(Duration(seconds: 1)).then((_) {
        _allowReset = true; //allow buttons to rebuild
        _games.increaseRound(); //next round
        if (answeredText == _correctAnswer) {
          //if answer was correct play sound and  give points
          if (_sounds) playLocalAsset("sounds/correct.mp3");
          _game.answeredCorrectly(
              _questionList[_game.getCurrentQuestionId].difficulty);
        } else {
          //if wrong vibrate and play the wrong sound
          if (_sounds) playLocalAsset("sounds/wrong.mp3");
          if (_vibrate) Vibration.vibrate();
        }
        if (_game.roundNumber < _game.numberOfQuestions) {
          //if game is not ended save it
          _games.saveCurrentGame();
        }
      });
    } else {
      //if game is ended go to the end of game screen
      Navigator.of(context).pushReplacementNamed(EndOfGameScreen.routeName);
    }
  }

  //AudioPlayer for correct and wrong sounds
  Future<AudioPlayer> playLocalAsset(String soundFile) async {
    if (_sounds) {
      AudioCache cache = new AudioCache();
      return await cache.play(soundFile);
    }
    return null;
  }

  //Loads questions list for the selected language and settings on init
  @override
  void initState() {
    super.initState();
    _questionList = Provider.of<Questions>(context, listen: false).getQuestions;
    var settings = Provider.of<Settings>(context, listen: false);
    _sounds = settings.getSoundSetting;
    _vibrate = settings.getVibrationSetting;
  }

  @override
  Widget build(BuildContext context) {
    _games = Provider.of<Games>(context);
    _game = _games.getGame;
    if (_allowReset) {
      //Resets button color and text when the tree rebuilds (on games provider notify listeners)
      int currentQuestionId = _game.getCurrentQuestionId;
      _buttonText = [
        //Fills button list with current answers
        _questionList[currentQuestionId].correctAnswer,
        _questionList[currentQuestionId].wrongAnswer1,
        _questionList[currentQuestionId].wrongAnswer2,
        _questionList[currentQuestionId].wrongAnswer3,
      ];
      _buttonText
          .shuffle(); // Shuffles the current list so answers on buttons can be randomised
      _question = _questionList[currentQuestionId].question;
      _correctAnswer = _questionList[currentQuestionId].correctAnswer;
      _uploader = _questionList[currentQuestionId].uploader;
      _source = _questionList[currentQuestionId].source;
      _buttonColors = [
        //Resets button colors to default
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor,
      ];
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        //Custom appbar with set size
        preferredSize: Size(
          double.infinity,
          screenHeight(context, dividedBy: 13),
        ),
        child: Container(
          //Container to color the appbar and move it under the notification bar
          color: Theme.of(context).primaryColorDark,
          padding: EdgeInsets.only(
              top: screenHeightToolbar(context, increasedBy: 4), bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GameInfoButton(_uploader, _source),
              //Button that opens a list with info about the question
              GameStats(
                  AppLocalizations.of(context)
                      .correct, //Correct and wrong Stats strip
                  _game.getNumberOfCorrectAnswers),
              GameStats(AppLocalizations.of(context).wrong,
                  _game.getNumberOfWrongAnswers),
              IconButton(
                //Button that exits the game if pressed
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).primaryColorLight,
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
                  child: AutoSizeText(_question,
                      style: Theme.of(context).textTheme.body1,
                      textAlign: TextAlign.center),
                  alignment: Alignment.topCenter,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColorDark, width: 5),
                borderRadius: BorderRadius.all(
                  const Radius.circular(5),
                ),
              ),
              child: SingleTouchRecognizerWidget(
                //So Emil does not doubleClick the answers
                child: AbsorbPointer(
                  //Forbids clicks on the answer buttons after one is pressed
                  absorbing: !_allowReset,
                  child: Column(
                    children: <Widget>[
                      answerFlatButton(
                        _buttonText[0],
                        _buttonColors[0],
                        () {
                          buttonPressed(_buttonText[0], 0);
                        },
                      ),
                      DividerQuestionButton(), //Divider between lines
                      answerFlatButton(
                        _buttonText[1],
                        _buttonColors[1],
                        () {
                          buttonPressed(_buttonText[1], 1);
                        },
                      ),
                      DividerQuestionButton(),
                      answerFlatButton(
                        _buttonText[2],
                        _buttonColors[2],
                        () {
                          buttonPressed(_buttonText[2], 2);
                        },
                      ),
                      DividerQuestionButton(),
                      answerFlatButton(
                        _buttonText[3],
                        _buttonColors[3],
                        () {
                          buttonPressed(_buttonText[3], 3);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //One of the 4 answer buttons to avoid code duplication
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
