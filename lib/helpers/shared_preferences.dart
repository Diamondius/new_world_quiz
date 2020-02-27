import 'dart:convert';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:new_world_quiz/locale/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    String languageCode = prefs.getString(_kLanguageCode) ??
        Intl.getCurrentLocale().substring(0, 2);
    return languageCode;
  }

  static Future<Locale> getLanguageLocale() async {
    String languageCode = await getLanguageCode();
    return AppLocalizations.getLocaleByCode(languageCode);
  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------
  static Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kLanguageCode, value);
  }

  static Future<bool> saveGame(int gameType, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(gameType.toString(), value);
  }

  static Future<Map<String, Object>> loadGame(int gameType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(gameType.toString())) {
      return jsonDecode(prefs.getString(gameType.toString()));
    } else
      return null;
  }

  static Future<bool> removeGame(int gameType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(gameType.toString())) {
      return prefs.remove(gameType.toString());
    } else {
      return false;
    }
  }

  static Future<bool> keyExists(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<bool> getSoundsSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("sounds")) {
      return prefs.getBool("sounds");
    } else
      return true;
  }

  static Future<bool> setSoundSetting(bool sound) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("sounds", sound);
  }

  static Future<bool> getVibrationSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("vibration")) {
      return prefs.getBool("vibration");
    } else
      return true;
  }

  static Future<bool> setVibrationSetting(bool vibration) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("vibration", vibration);
  }
}
