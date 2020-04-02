import 'package:flutter/foundation.dart';
import 'package:new_world_quiz/helpers/shared_preferences.dart';

class Settings with ChangeNotifier {
  bool sound = true;
  bool animations = true;
  bool vibration = true;

  Settings() {
    _getSoundsSettings();
    _getVibrationSettings();
  }

  void _getSoundsSettings() async {
    sound = await SharedPreferencesHelper.getSoundsSetting();
    print("Get Sound = ${sound.toString()}");
    notifyListeners();
  }

  void setSoundSettings(bool sound) {
    this.sound = sound;
    print("Set Sound = ${sound.toString()}");
    SharedPreferencesHelper.setSoundSetting(sound).then((_) {
      notifyListeners();
    });
  }

  bool get getSoundSetting {
    return sound;
  }

  void _getVibrationSettings() async {
    vibration = await SharedPreferencesHelper.getVibrationSetting();
    notifyListeners();
  }

  void setVibrationSettings(bool vibration) {
    this.vibration = vibration;
    SharedPreferencesHelper.setVibrationSetting(vibration).then((_) {
      notifyListeners();
    });
  }

  bool get getVibrationSetting {
    return vibration;
  }
}
