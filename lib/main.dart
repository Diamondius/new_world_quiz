import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './helpers/shared_preferences.dart';
import './locale/app_localization.dart';
import './providers/games.dart';
import './providers/language.dart';
import './providers/questions.dart';
import './providers/settings.dart';
import './screens/end_of_game_screen.dart';
import './screens/game_screen.dart';
import './screens/home_screen.dart';
import './screens/submit_feedback_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  Questions _questions;

  //Initialises the language Provider and the language Locale from SharedPreferences. Rebuilds app when language is loaded async.
  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.getLanguageLocale().then((locale) {
      setState(() {
        this._locale = locale;
        _questions = Questions(locale.languageCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //Changes Status bar color to Dark Purple
      statusBarColor: Colors.deepPurple.shade900,
    ));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); //Lock app to Portrait
    return this._locale == null
        ? CircularProgressIndicator() //Progress indicator when language is not yet available
        : MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) =>
                    Language.provider(code: this._locale.languageCode),
              ),
              ChangeNotifierProvider.value(
                value: _questions,
              ),
              ChangeNotifierProxyProvider<Questions, Games>(
                create: (_) => Games(_questions),
                update: (BuildContext context, Questions questions,
                        Games previous) =>
                    Games(questions),
              ),
              ChangeNotifierProvider(
                create: (_) => Settings(),
              )
            ],
            child: Consumer<Language>(
              builder: (context, language, child) {
                return MaterialApp(
                  title: "NW Quiz",
                  theme: ThemeData(
                    canvasColor: Colors.deepPurple.shade100,
                    primaryColor: Colors.deepPurple,
                    primaryColorDark: Colors.deepPurple.shade900,
                    backgroundColor: Colors.deepPurple.shade300,
                    dividerColor: Colors.deepPurple.shade100,
                    accentColor: Colors.green,
                    iconTheme: IconThemeData(color: Colors.white),
                    accentIconTheme: IconThemeData(color: Colors.green),
                    textTheme: TextTheme(
                      body1: TextStyle(
                          color: Colors.deepPurple.shade900,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Alegreya"),
                      body2: TextStyle(
                          color: Colors.deepPurple.shade900,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Alegreya"),
                      button: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Alegreya"),
                      title: language.titleTextStyle(),
                      overline: language.overheadTextStyle(),
                      subtitle: language.settingsTextStyle(),
                    ),
                  ),
                  routes: {
                    HomeScreen.routeName: (ctx) => HomeScreen(),
                    GameScreen.routeName: (ctx) => GameScreen(),
                    EndOfGameScreen.routeName: (ctx) => EndOfGameScreen(),
                    SubmitFeedbackScreen.routeName: (ctx) =>
                        SubmitFeedbackScreen(),
                  },
                  locale: this._locale,
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.delegate.supportedLocales,
                  home: HomeScreen(),
                );
              },
            ),
          );
  }
}
