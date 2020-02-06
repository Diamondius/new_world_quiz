import 'package:flutter/material.dart';
import 'package:new_world_quiz/helpers/shared_preferences.dart';
import 'package:new_world_quiz/locale/app_localization.dart';

class Language with ChangeNotifier {
  String nameEnglish;
  String nameGreek;
  String nameRussian;
  String code;
  Locale locale;

  Language(this.nameEnglish, this.nameGreek, this.nameRussian, this.code,
      this.locale);

  //Current list of supported languages to use as maps on dropdown
  static List<Language> _languages = [
    Language("English", "Αγγλικά", "английский", "en", Locale("en", "US")),
    Language("Greek", "Ελληνικά", "греческий", "el", Locale("el", "GR")),
    Language("Russian", "Ρωσικά", "русский", "ru", Locale("ru", "RU")),
  ];

  static List<Language> get getLanguages {
    return [..._languages];
  }

  Language.provider({@required this.code});

  static String languageName(Language language, String currentLanguage) {
    switch (currentLanguage) {
      case "el":
        return language.nameGreek;
      case "ru":
        return language.nameRussian;
      default:
        return language.nameEnglish;
    }
  }

  void setLanguageCode(String languageCode) {
    this.code = languageCode;
    SharedPreferencesHelper.setLanguageCode(languageCode);
    AppLocalizations.load(AppLocalizations.getLocaleByCode(languageCode));
    notifyListeners();
  }

  String fontFamily() {
    switch (code) {
      case "el":
        return "Caudex";
      case "ru":
        return "Pattaya";
      default:
        return "CinzelDecorative";
    }
  }

  TextStyle titleTextStyle() {
    switch (code) {
      case "el":
        return TextStyle(
            color: Colors.deepPurple.shade900,
            fontFamily: fontFamily(),
            fontSize: 40,
            fontWeight: FontWeight.bold);
      case "ru":
        return TextStyle(
            color: Colors.deepPurple.shade900,
            fontFamily: fontFamily(),
            fontSize: 40);
      default:
        return TextStyle(
            color: Colors.deepPurple.shade900,
            fontFamily: fontFamily(),
            fontSize: 40,
            fontWeight: FontWeight.w900);
    }
  }

  TextStyle overheadTextStyle() {
    switch (code) {
      case "el":
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: fontFamily(),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        );
      case "ru":
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: fontFamily(),
          fontSize: 25,
        );
      default:
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: fontFamily(),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        );
    }
  }

  TextStyle settingsTextStyle() {
    switch (code) {
      case "el":
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: fontFamily(),
          fontSize: 20,
        );
      case "ru":
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: fontFamily(),
          fontSize: 20,
        );
      default:
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: fontFamily(),
          fontSize: 20,
        );
    }
  }
}
