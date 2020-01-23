import 'package:flutter/material.dart';
import 'package:new_world_quiz/helpers/shared_preferences.dart';
import 'package:new_world_quiz/locale/app_localization.dart';

class Language with ChangeNotifier {
  String nameEnglish;
  String nameGreek;
  String code;
  Locale locale;

  Language(this.nameEnglish, this.nameGreek, this.code, this.locale);

  //Current list of supported languages to use as maps on dropdown
  static List<Language> _languages = [
    Language("English", "Αγγλικά", "en", Locale("en", "US")),
    Language("Greek", "Ελληνικά", "el", Locale("el", "GR")),
  ];

  static List<Language> get getLanguages {
    return [..._languages];
  }

  Language.provider({@required this.code});

  static String languageName(Language language, String currentLanguage) {
    switch (currentLanguage) {
      case "el":
        return language.nameGreek;
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
      default:
        return "CinzelDecorative";
    }
  }

  TextStyle titleTextStyle() {
    switch (code) {
      case "el":
        return TextStyle(
            color: Colors.deepPurple.shade900,
            fontFamily: "Caudex",
            fontSize: 40,
            fontWeight: FontWeight.bold);
      default:
        return TextStyle(
            color: Colors.deepPurple.shade900,
            fontFamily: "CinzelDecorative",
            fontSize: 40,
            fontWeight: FontWeight.w900);
    }
  }

  TextStyle overheadTextStyle() {
    switch (code) {
      case "el":
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: "Caudex",
          fontSize: 25,
          fontWeight: FontWeight.bold,
        );
      default:
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: "CinzelDecorative",
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
          fontFamily: "Caudex",
          fontSize: 20,
        );
      default:
        return TextStyle(
          color: Colors.deepPurple.shade900,
          fontFamily: "CinzelDecorative",
          fontSize: 20,
        );
    }
  }
}
