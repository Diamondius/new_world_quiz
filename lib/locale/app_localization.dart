import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import "../l10n/messages_all.dart";

class AppLocalizations {
  AppLocalizations();

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  //Returns list of supported locales
  static List<Locale> get getLocaleList {
    return delegate.supportedLocales;
  }

  //Returns full locale by providing the language code
  static Locale getLocaleByCode(String languageCode) {
    return delegate.supportedLocales
        .firstWhere((language) => language.languageCode == languageCode);
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // list of locales
  String get nwQuiz {
    return Intl.message(
      'NEW WORLD QUIZ',
      name: 'nwQuiz',
      desc: 'The title for the app',
    );
  }

  String get welcomeTo {
    return Intl.message(
      "WELCOME TO",
      name: "welcomeTo",
      desc: "Title overhead welcome",
    );
  }

  String get exclamationPerfect {
    return Intl.message(
      "PERFECT!",
      name: "exclamationPerfect",
      desc: "End Game Title for a perfect Score",
    );
  }

  String get exclamationGreat {
    return Intl.message(
      "GREAT JOB!",
      name: "exclamationGreat",
      desc: "End Game Title for a great score",
    );
  }

  String get exclamationGood {
    return Intl.message(
      "GOOD JOB!",
      name: "exclamationGood",
      desc: "End Game Title for a good score",
    );
  }

  String get exclamationThank {
    return Intl.message(
      "NICE TRY!",
      name: "exclamationThank",
      desc: "End Game Title for a low score",
    );
  }

  String get evaluationPerfect {
    return Intl.message(
      "You have reached the heights of Biblical knowledge. Put it to good use!",
      name: "evaluationPerfect",
      desc: "End Game evaluation for a perfect score",
    );
  }

  String get evaluationGreat {
    return Intl.message(
      "You have an in depth knowledge of the Bible. Continue your hard work!",
      name: "evaluationGreat",
      desc: "End Game evaluation for a great score",
    );
  }

  String get evaluationGood {
    return Intl.message(
      "You have demonstrated a working knowledge of the Bible. Always keep improving!",
      name: "evaluationGood",
      desc: "End Game evaluation for a good score",
    );
  }

  String get evaluationThank {
    return Intl.message(
      "Gaining Biblical knowledge is a life long journey, never give up!",
      name: "evaluationThank",
      desc: "End Game evaluation for a lower than half score",
    );
  }

  String get buttonEndGame {
    return Intl.message(
      "End Game",
      name: "buttonEndGame",
      desc: "End Game button text",
    );
  }

  String get inDepth {
    return Intl.message(
      "More in depth",
      name: "inDepth",
      desc: "End Game In Depth title",
    );
  }

  String get correctAnswers {
    return Intl.message(
      "Correct Answers",
      name: "correctAnswers",
      desc: "End Game correct answers",
    );
  }

  String get totalPoints {
    return Intl.message(
      "Total Points",
      name: "totalPoints",
      desc: "End Game total points",
    );
  }

  String get settings {
    return Intl.message(
      "Settings",
      name: "settings",
      desc: "Settings Title",
    );
  }

  String get quickGameButton {
    return Intl.message(
      "Quick Game",
      name: "quickGameButton",
      desc: "Quick Game Button Title",
    );
  }

  String get home {
    return Intl.message(
      "Home",
      name: "home",
      desc: "Central app page on navigaton bar",
    );
  }

  String get language {
    return Intl.message(
      "Language",
      name: "language",
      desc: "Settings language",
    );
  }

  String get by {
    return Intl.message(
      "By:",
      name: "by",
      desc: "By whom was the question uploaded",
    );
  }

  String get correct {
    return Intl.message(
      "Correct",
      name: "correct",
      desc: "Correct questions answered",
    );
  }

  String get wrong {
    return Intl.message(
      "Wrong",
      name: "wrong",
      desc: "Wrong questions answered",
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  // Override with your list of supported language codes
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en', 'US'),
      Locale('el', 'GR'),
      Locale('ru', 'RU'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
