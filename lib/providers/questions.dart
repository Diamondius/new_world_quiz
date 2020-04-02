import 'package:flutter/foundation.dart';
import 'package:new_world_quiz/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../models/question.dart';

class Questions with ChangeNotifier {
  List<Question> _questions = [];

  Questions(String language) {
    if (_questions.isEmpty) fetchAndSetQuestions(language);
  }

  set setQuestionsList(List<Question> questions) {
    _questions = questions;
    notifyListeners();
  }

  List<Question> get getQuestions {
    return [..._questions];
  }

  void fetchAndSetQuestions(String languageCode) {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Question>> questionListFuture =
          databaseHelper.getQuestionsList(languageCode);
      questionListFuture.then((questions) {
        setQuestionsList = questions;
        print(questions.length.toString());
      });
    });
  }
}
