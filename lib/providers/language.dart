import 'package:flutter/material.dart';
import 'package:new_world_quiz/helpers/shared_preferences.dart';
import 'package:new_world_quiz/locale/app_localization.dart';

class Language with ChangeNotifier {
  String nameEnglish;
  String nameGreek;
  String nameRussian;
  String nameGerman;
  String nameAlbanian;
  String code;
  Locale locale;

  Language(this.nameEnglish, this.nameGreek, this.nameRussian, this.nameGerman,
      this.nameAlbanian, this.code, this.locale);

  //Current list of supported languages to use as maps on dropdown
  static List<Language> _languages = [
    Language(
      "English",
      "Αγγλικά",
      "Английский",
      "Englisch",
      "Angleze",
      "en",
      Locale("en", "US"),
    ),
    Language(
      "Greek",
      "Ελληνικά",
      "Греческий",
      "Griechisch",
      "Greke",
      "el",
      Locale("el", "GR"),
    ),
    Language(
      "Russian",
      "Ρωσικά",
      "Русский",
      "Russisch",
      "Ruse",
      "ru",
      Locale("ru", "RU"),
    ),
    Language(
      "German",
      "Γερμανικά",
      "Немецкий",
      "Deutsch",
      "Gjermane",
      "de",
      Locale("de", "DE"),
    ),
    Language(
      "Albanian",
      "Αλβανικά",
      "Албанский",
      "Albanisch",
      "Shqipe",
      "sq",
      Locale("sq", "AL"),
    ),
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
      case "de":
        return language.nameGerman;
      case "sq":
        return language.nameAlbanian;
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
}
