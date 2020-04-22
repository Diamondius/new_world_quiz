import 'dart:convert';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locale/app_localization.dart';

//Helper class for storing and retrieving variables from shared Preferences
class SharedPreferencesHelper {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _kLanguageCode = "language";

  /// ------------------------------------------------------------
  /// Method that returns the user language code, 'en' if not set
  /// ------------------------------------------------------------
  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String languageCode = prefs.getString(_kLanguageCode) ??
        Intl.getCurrentLocale().substring(0, 2);
    return languageCode;
  }

  static Future<Locale> getLanguageLocale() async {
    final String languageCode = await getLanguageCode();
    return AppLocalizations.getLocaleByCode(languageCode);
  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------
  static Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kLanguageCode, value);
  }

  /// ----------------------------------------------------------
  /// Method that saves the current game object
  /// ----------------------------------------------------------
  static Future<bool> saveGame(int gameType, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(gameType.toString(), value);
  }

  /// ----------------------------------------------------------
  /// Method that loads the current game object
  /// ----------------------------------------------------------
  static Future<Map<String, Object>> loadGame(int gameType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(gameType.toString())) {
      return jsonDecode(prefs.getString(gameType.toString()));
    } else
      return null;
  }

  /// ----------------------------------------------------------
  /// Method that removes the current game object from sharedPreferences
  /// ----------------------------------------------------------
  static Future<bool> removeGame(int gameType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(gameType.toString())) {
      return prefs.remove(gameType.toString());
    } else {
      return false;
    }
  }

  /// ----------------------------------------------------------
  /// Method that checks if a key in sharedPreferences exists
  /// ----------------------------------------------------------
  static Future<bool> keyExists(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  /// ----------------------------------------------------------
  /// Method that loads the bool that shows if the sound is enabled
  /// ----------------------------------------------------------
  static Future<bool> getSoundsSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("sounds")) {
      return prefs.getBool("sounds");
    } else
      return true;
  }

  /// ----------------------------------------------------------
  /// Method that saves the bool that shows if the sound is enabled
  /// ----------------------------------------------------------
  static Future<bool> setSoundSetting(bool sound) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("sounds", sound);
  }

  /// ----------------------------------------------------------
  /// Method that loads the bool that shows if the vibration is enabled
  /// ----------------------------------------------------------
  static Future<bool> getVibrationSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("vibration")) {
      return prefs.getBool("vibration");
    } else
      return true;
  }

  /// ----------------------------------------------------------
  /// Method that saves the bool that shows if the vibration is enabled
  /// ----------------------------------------------------------
  static Future<bool> setVibrationSetting(bool vibration) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("vibration", vibration);
  }

  /// ----------------------------------------------------------
  /// Method that returns the last saved version of the app
  /// ----------------------------------------------------------
  static Future<String> getVersion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("version")) {
      return prefs.getString("version");
    } else {
      String tempVersion = "0.0.1";
      await setVersion(tempVersion);
      return tempVersion;
    }
  }

  /// ----------------------------------------------------------
  /// Method that saves the current version of the app. Last 2 are used to update the question database every update
  /// ----------------------------------------------------------
  static Future<bool> setVersion(String version) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("version", version);
  }
}
