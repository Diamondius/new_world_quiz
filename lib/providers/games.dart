import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:new_world_quiz/helpers/shared_preferences.dart';
import 'package:new_world_quiz/models/question.dart';
import 'package:new_world_quiz/providers/questions.dart';

import '../models/game.dart';

class Games with ChangeNotifier {
  Games(this.questions);

  Questions questions;

  List<Game> _games = [null, null, null];
  int gameType = 0; //0 = Custom Game, 1 = Ranked Game, 2 = Endless Game

  void newCustomGame(int numberOfQuestions, int diff) {
    _games[0] = Game.initialize(
        questionIds: questionIdList(numberOfQuestions, diff),
        numberOfQuestions: numberOfQuestions);
    notifyListeners();
  }

  List<int> questionIdList(int numberOfQuestions, int diff) {
    List<int> idList = [];
    List<Question> questionList = [];
    int maxNumberOfQuestions = questions.getQuestions.length;
    switch (diff) {
      case 1:
        questionList = questions.getQuestions
            .where((question) => question.difficulty < 5)
            .toList();
        break;
      case 2:
        questionList = questions.getQuestions
            .where((question) =>
        question.difficulty > 3 && question.difficulty < 8)
            .toList();
        break;
      case 3:
        questionList = questions.getQuestions
            .where((question) => question.difficulty > 5)
            .toList();
        break;
      default:
        idList = List<int>.generate(maxNumberOfQuestions, (i) => i + 1);
        break;
    }
    if (questionList.length > 0) {
      questionList.forEach((question) {
        idList.add(question.id -
            1); //Minus 1 is necessary because database index starts from 1
      });
    }
    idList.shuffle();
    idList.length = numberOfQuestions;
    print(idList);
    return idList;
  }

  List<Game> get getGames {
    return _games;
  }

  Game get getGame {
    return _games[gameType];
  }

  void increaseRound() {
    _games[gameType].increaseRound();
    notifyListeners();
  }

  void saveCurrentGame() {
    Map<String, dynamic> jsonGame = _games[gameType].toJson();
    SharedPreferencesHelper.saveGame(gameType, jsonEncode(jsonGame));
  }

  void loadGame() {
    SharedPreferencesHelper.keyExists(gameType.toString()).then((exists) {
      if (exists) {
        SharedPreferencesHelper.loadGame(gameType).then((gameMap) {
          _games[gameType] = Game.fromJson(gameMap);
          print("Game Loaded");
          print(_games[0].toJson().toString());
          notifyListeners();
        });
      }
    });
  }

  Future<bool> nullifyGame() {
    _games[gameType] = null;
    print("Game Deleted");
    notifyListeners();
    return SharedPreferencesHelper.removeGame(gameType);
  }
}
