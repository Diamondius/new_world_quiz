import 'package:flutter/foundation.dart';

class Game {
  final int numberOfQuestions;
  final List<int> questionIds;
  int roundNumber;
  int correct;
  int points;

  Game.initialize({
    @required this.numberOfQuestions,
    @required this.questionIds,
    this.roundNumber = 1,
    this.correct = 0,
    this.points = 0,
  });

  int get getRoundNumber {
    return roundNumber;
  }

  int get getNumberOfQuestions {
    return numberOfQuestions;
  }

  int get getNumberOfCorrectAnswers {
    return correct;
  }

  int get getPoints {
    return points;
  }

  void increaseRound() {
    roundNumber++;
  }

  void answeredCorrectly(int difficulty) {
    correct++;
    points += 100 * difficulty;
  }
}

class Games with ChangeNotifier {
  Games();

  Game _games;
  int _questionCount;

  void newGame(int allQuestionsCount) {
    List<int> idList = List<int>.generate(allQuestionsCount, (i) => i + 1);
    idList.shuffle();
    idList.length = 20;
    _games =
        Game.initialize(questionIds: idList, numberOfQuestions: idList.length);
    _questionCount = idList.length;
    notifyListeners();
  }

  Game get getGame {
    return _games;
  }

  int get getCurrentQuestionId {
    int currentQuestionId = _games.questionIds[_games.getRoundNumber - 1];
    return currentQuestionId;
  }

  int get getNumberOfQuestions {
    return _questionCount;
  }

  int get getNumberOfCorrectAnswers {
    return _games.getNumberOfCorrectAnswers;
  }

  int get getNumberOfWrongAnswers {
    return (_games.getRoundNumber - 1) - _games.getNumberOfCorrectAnswers;
  }

  int get getPoints {
    return _games.getPoints;
  }

  int get getCurrentRound {
    return _games.getRoundNumber;
  }

  void answeredCorrectly(int difficulty) {
    _games.answeredCorrectly(difficulty);
  }

  void increaseRound() {
    _games.increaseRound();
    notifyListeners();
  }
}
