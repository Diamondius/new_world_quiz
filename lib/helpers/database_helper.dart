import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../helpers/shared_preferences.dart';
import '../models/question.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  //Table name that holds the shared information for each question
  static const String _sharedTable = "shared_info";

  //Table name that switches according to current locale
  String _questionsTable(String language) {
    return "multiple_choice_$language";
  }

  DatabaseHelper._createInstance(); //Database helper singleton

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //Database version control. Refreshes the database on every code change since it is using preloaded sqLite database.
    PackageInfo packageInfo =
        await PackageInfo.fromPlatform(); //Loads the app's version
    final String _version = packageInfo.version;
    final String _savedVersion = await SharedPreferencesHelper.getVersion();
    print("Version: $_version");
    print("Saved Version: $_savedVersion");
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "questions.db");
    // Check if the database exists
    var _exists = await databaseExists(path);
    if (_exists && _version != _savedVersion) {
      //If version is changed it deletes the previous one and loads a new one
      await deleteDatabase(path);
      print("Database Deleted");
      SharedPreferencesHelper.setVersion(_version);
      _exists = await databaseExists(path);
    }
    if (!_exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      // Copy from asset
      final ByteData data =
      await rootBundle.load(join("assets", "questions.db"));
      final List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }
    // open the database
    final questionsDatabase = await openDatabase(path, readOnly: true);
    questionsDatabase.getVersion().then((onValue) {});
    return questionsDatabase;
  }

  // Fetch Operation: Get all question objects from database
  Future<List<Map<String, dynamic>>> getQuestionMapList(String language) async {
    final Database db = await this.database;
    final result = await db.query(_questionsTable(language));
    return result;
  }

  // Fetch Operation: Get all question objects from database
  Future<List<Map<String, dynamic>>> getSharedMapList() async {
    final Database db = await this.database;
    final result = await db.query(_sharedTable);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'questions List' [ List<Questions> ]
  Future<List<Question>> getQuestionsList(String language) async {
    final questionsMapList =
        await getQuestionMapList(language); // Get 'Map List' from database
    final sharedMapList = await getSharedMapList();
    final int count =
        questionsMapList.length; // Count the number of map entries in db table
    final List<Question> questionsList = List<Question>();
    // For loop to create a 'questions List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      questionsList
          .add(Question.fromMapObject(questionsMapList[i], sharedMapList[i]));
    }
    return questionsList;
  }
}
