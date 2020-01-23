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
}
