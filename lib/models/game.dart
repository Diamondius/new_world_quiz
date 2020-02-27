import 'dart:convert';

import 'package:flutter/foundation.dart';

class Game {
  final int numberOfQuestions;
  final List<int> questionIds;
  int roundNumber;
  int correct;
  int points;

  Game(
      {this.numberOfQuestions,
      this.questionIds,
      this.points,
      this.correct,
      this.roundNumber});

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

  int get getCurrentQuestionId {
    return questionIds[roundNumber - 1];
  }

  int get getNumberOfQuestions {
    return numberOfQuestions;
  }

  int get getNumberOfCorrectAnswers {
    return correct;
  }

  int get getNumberOfWrongAnswers {
    return (roundNumber - 1) - correct;
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

  Map<String, dynamic> toJson() {
    String jsonList = jsonEncode(questionIds);
    return {
      'numberOfQuestions': numberOfQuestions,
      'questionIds': jsonList,
      'roundNumber': roundNumber,
      'correct': correct,
      'points': points,
    };
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    var questionIdsText = jsonDecode(json["questionIds"]);
    List<int> questionIds =
        questionIdsText != null ? List.from(questionIdsText) : null;
    return Game(
      numberOfQuestions: json['numberOfQuestions'],
      questionIds: questionIds,
      roundNumber: json['roundNumber'],
      correct: json['correct'],
      points: json['points'],
    );
  }
}
