import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/model/user_settings.dart';

import '../enums/sex.dart';

class SharedPrefService {
  static const userNameKey = 'usernameKey';
  static const radioListTileKey = 'radioListTileKey';
  static const colorsKey = 'colorsKey';
  static const switchListTileKey = 'switchListTileKey';
  static const lightKey = 'light';

  void saveUserSettings(UserSettingsModel model) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(userNameKey, model.userName);
    sharedPref.setInt(radioListTileKey, model.sex.index);
    sharedPref.setBool(lightKey, model.light);
    sharedPref.setBool(switchListTileKey, model.darkTheme);
    sharedPref.setStringList(colorsKey, model.color);
  }

  Future<UserSettingsModel> getUserSettings() async {
    final sharedPref = await SharedPreferences.getInstance();
    final light = sharedPref.getBool(lightKey) ?? false;
    final userName = sharedPref.getString(userNameKey) ?? '';
    final sex = Sex.values[sharedPref.getInt(radioListTileKey) ?? 0];
    final colors = sharedPref.getStringList(colorsKey) ?? [];
    final theme = sharedPref.getBool(switchListTileKey) ?? false;
    return UserSettingsModel(
        userName: userName,
        sex: sex,
        color: colors,
        darkTheme: theme,
        light: light);
  }
}
