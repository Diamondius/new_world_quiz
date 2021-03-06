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
      "Welcome to",
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
      desc: "Central app page on navigation bar",
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

  String get source {
    return Intl.message(
      "Source",
      name: "source",
      desc: "Source of a question found in Online Library",
    );
  }

  String get noSource {
    return Intl.message(
      "No Source",
      name: "noSource",
      desc: "No source found for the specific question",
    );
  }

  String get cancel {
    return Intl.message(
      "Cancel",
      name: "cancel",
      desc: "Cancel button to close Alert window",
    );
  }

  String get go {
    return Intl.message(
      "Go",
      name: "go",
      desc:
          "Go button on the alert window to move to the Watchtower library external site",
    );
  }

  String get sourceAlertWindowDescription {
    return Intl.message(
      "This will open an external browser window to the Watchtower Online Library, where the source of the question is referred.\n The site's double arrow icon can be used to change languages.\n If you choose to proceed, you forfeit this question.",
      name: "sourceAlertWindowDescription",
      desc:
          "Description for the source alert window. \n Is a symbol for changing the line.",
    );
  }

  String get custom {
    return Intl.message(
      "Custom",
      name: "custom",
      desc: "Custom Game Icon Text",
    );
  }

  String get customGame {
    return Intl.message(
      "Custom Game",
      name: "customGame",
      desc: "Custom Game Title Text Text",
    );
  }

  String get play {
    return Intl.message(
      "Play",
      name: "play",
      desc: "Play Game",
    );
  }

  String get continueGame {
    return Intl.message(
      "Continue",
      name: "continueGame",
      desc: "Continue Game",
    );
  }

  String get random {
    return Intl.message(
      "Random",
      name: "random",
      desc: "Random difficulty of questions",
    );
  }

  String get easy {
    return Intl.message(
      "Easy",
      name: "easy",
      desc: "Easy difficulty of questions",
    );
  }

  String get normal {
    return Intl.message(
      "Normal",
      name: "normal",
      desc: "Normal difficulty of questions",
    );
  }

  String get hard {
    return Intl.message(
      "Hard",
      name: "hard",
      desc: "Hard difficulty of questions",
    );
  }

  String get difficulty {
    return Intl.message(
      "Difficulty",
      name: "difficulty",
      desc: "How difficult the questions are",
    );
  }

  String get questions {
    return Intl.message(
      "Questions",
      name: "questions",
      desc: "Questions",
    );
  }

  String get sound {
    return Intl.message(
      "Sound",
      name: "sound",
      desc: "Option to enable or disable sounds",
    );
  }

  String get vibration {
    return Intl.message(
      "Vibration",
      name: "vibration",
      desc: "Option to enable or disable vibration",
    );
  }

  String get feedback {
    return Intl.message(
      "Feedback",
      name: "feedback",
      desc: "Feedback from the user for the app",
    );
  }

  String get shareThoughts {
    return Intl.message(
      "Please share your thoughts about the app",
      name: "shareThoughts",
      desc: "Implores user to share their thoughts about the app",
    );
  }

  String get feedbackEmpty {
    return Intl.message(
      "Please write some feedback before sending",
      name: "feedbackEmpty",
      desc: "Message for when someone leaves the feedback textfield empty",
    );
  }

  String get feedbackFewChars {
    return Intl.message(
      "Please write more than 10 characters",
      name: "feedbackFewChars",
      desc: "Message for when someone writes under 10 characters in feedback",
    );
  }

  String get contact {
    return Intl.message(
      "Contact Us",
      name: "contact",
      desc: "Contact us title on settings page",
    );
  }

  String get shareQuestion {
    return Intl.message(
      "Share your Question",
      name: "shareQuestion",
      desc: "Share a question on settings page",
    );
  }

  String get reportQuestion {
    return Intl.message(
      "Report Question",
      name: "reportQuestion",
      desc: "Report question title on the page",
    );
  }

  String get newQuestion {
    return Intl.message(
      "New Question",
      name: "newQuestion",
      desc: "Report question title on the page",
    );
  }

  String get reportQuestionUnderline {
    return Intl.message(
      "Please share what is wrong with this question",
      name: "reportQuestionUnderline",
      desc: "Ask them to share the issue with the question",
    );
  }

  String get shareQuestionUnderline {
    return Intl.message(
      "Please share a question with us",
      name: "shareQuestionUnderline",
      desc: "Ask them to share a question under the title",
    );
  }

  String get question {
    return Intl.message(
      "Question",
      name: "question",
      desc: "Single question for the new question form hint",
    );
  }

  String get correctAnswer {
    return Intl.message(
      "Correct Answer",
      name: "correctAnswer",
      desc: "Correct answer for the new question form hint",
    );
  }

  String get wrongAnswer {
    return Intl.message(
      "Wrong Answer",
      name: "wrongAnswer",
      desc: "Wrong answer for the new question form hint",
    );
  }

  String get emptyQuestionError {
    return Intl.message(
      "Please write a question!",
      name: "emptyQuestionError",
      desc: "Error you see when the question form is empty",
    );
  }

  String get emptyAnswerError {
    return Intl.message(
      "Please write an answer!",
      name: "emptyAnswerError",
      desc: "Error you see when the answer form is empty",
    );
  }

  String get shortQuestionError {
    return Intl.message(
      "Please make the question longer!",
      name: "shortQuestionError",
      desc: "Error you see when the question form has too few characters",
    );
  }

  String get longAnswerError {
    return Intl.message(
      "Shorten the answer to fewer than 100 characters!",
      name: "longAnswerError",
      desc: "Error you see when the answer form is too long",
    );
  }

  String get signIn {
    return Intl.message(
      "Sign In",
      name: "signIn",
      desc: "Sign in page icon text",
    );
  }

  String get signUp {
    return Intl.message(
      "Sign Up",
      name: "signUp",
      desc: "Sign up page icon text",
    );
  }

  String get signOut {
    return Intl.message(
      "Logout",
      name: "signOut",
      desc: "Sign out page icon text",
    );
  }

  String get user {
    return Intl.message(
      "User",
      name: "user",
      desc: "User page icon text",
    );
  }

  String get withEmail {
    return Intl.message(
      "with E-Mail",
      name: "withEmail",
      desc: "Sign in with Email",
    );
  }

  String get offline {
    return Intl.message(
      "Offline",
      name: "offline",
      desc: "Play without internet(offline)",
    );
  }

  String get or {
    return Intl.message(
      "or",
      name: "or",
      desc: "Something OR another",
    );
  }

  get password {
    return Intl.message(
      "Password",
      name: "password",
      desc: "Password",
    );
  }

  String get email {
    return Intl.message(
      "E-Mail",
      name: "email",
      desc: "E-Mail",
    );
  }

  String get userName {
    return Intl.message(
      "Username",
      name: "userName",
      desc: "User Name",
    );
  }

  String get userNameFewChars {
    return Intl.message(
      "Username must be longer than 4 letters",
      name: "userNameFewChars",
      desc: "User Name too few characters",
    );
  }

  String get invalidEmailOrPassword {
    return Intl.message(
      "Invalid E-Mail or Password",
      name: "invalidEmailOrPassword",
      desc: "Invalid Email or Password",
    );
  }

  String get withGoogle {
    return Intl.message(
      "with Google",
      name: "withGoogle",
      desc: "Sign in with Google",
    );
  }

  String get onFacebook {
    return Intl.message(
      "with Facebook",
      name: "onFacebook",
      desc: "Sign in on Facebook",
    );
  }

  String get weakPassword {
    return Intl.message(
      "Your password is too weak",
      name: "weakPassword",
      desc: "Your password is too weak",
    );
  }

  String get invalidEmail {
    return Intl.message(
      "Your email is invalid",
      name: "invalidEmail",
      desc: "Your email is invalid",
    );
  }

  String get emailInUse {
    return Intl.message(
      "Email is already in use on a different account",
      name: "emailInUse",
      desc: "Email is already in use on different account",
    );
  }

  String get invalidPassword {
    return Intl.message(
      "You entered a wrong password",
      name: "invalidPassword",
      desc: "You entered a wrong password",
    );
  }

  String get userDisabled {
    return Intl.message(
      "This user account has been disabled",
      name: "userDisabled",
      desc: "This user account has been disabled",
    );
  }

  String get tooManyAttemptsToSignIn {
    return Intl.message(
      "Too many attempts to sign in as this user",
      name: "tooManyAttemptsToSignIn",
      desc: "Too many attempts to sign in as this user",
    );
  }

  String get invalidCredentials {
    return Intl.message(
      "Your login credentials are invalid",
      name: "invalidCredentials",
      desc: "Your login credentials are invalid",
    );
  }

  String get userNotFound {
    return Intl.message(
      "This user does not exist",
      name: "userNotFound",
      desc: "This user does not exist",
    );
  }

  String get errorVerification {
    return Intl.message(
      "An error occurred while trying to send the verification E-Mail",
      name: "errorVerification",
      desc: "An error occured while trying to send verification E-Mail",
    );
  }

  String get resetPassword {
    return Intl.message(
      "Reset password",
      name: "resetPassword",
      desc: "Reset password",
    );
  }

  String get forgotPassword {
    return Intl.message(
      "Forgot your password?",
      name: "forgotPassword",
      desc: "forgotPassword",
    );
  }

  String get resetEmailSent {
    return Intl.message(
      "Reset password E-Mail sent",
      name: "resetEmailSent",
      desc: "Reset password E-Mail sent",
    );
  }

  String get unidentifiedError {
    return Intl.message(
      "An undefined Error happened",
      name: "unidentifiedError",
      desc: "An undefined Error happened",
    );
  }

  String get networkError {
    return Intl.message(
      "You are not connected to the Internet",
      name: "networkError",
      desc: "Network Error",
    );
  }

  String get facebookError {
    return Intl.message(
      "Facebook Error",
      name: "facebookError",
      desc: "Facebook Error",
    );
  }

  String get canceledByUser {
    return Intl.message(
      "Login cancelled by user",
      name: "canceledByUser",
      desc: "Login cancelled by user",
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
      Locale("de", "DE"),
      Locale("sq", "AL"),
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
