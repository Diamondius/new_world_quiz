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
import './screens/end_of_game_screen.dart';
import './screens/game_screen.dart';
import './screens/home_screen.dart';

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
  Locale locale;
  Questions questions;

  @override
  void initState() {
    super.initState();

    SharedPreferencesHelper.getLanguageLocale().then((locale) {
      setState(() {
        this.locale = locale;
        questions = Questions(locale.languageCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple.shade900,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return this.locale == null
        ? CircularProgressIndicator()
        : MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) =>
                    Language.provider(code: this.locale.languageCode),
              ),
              ChangeNotifierProvider.value(
                value: questions,
              ),
              ChangeNotifierProvider(
                create: (_) => Games(),
              ),
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
                  },
                  locale: this.locale,
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
