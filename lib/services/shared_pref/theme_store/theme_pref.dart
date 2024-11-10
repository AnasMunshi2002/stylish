import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefManager {
  static late final SharedPreferences prefManager;
  static String themeKey = "THEME_KEY";

  static initPref() async {
    prefManager = await SharedPreferences.getInstance();
  }

  static storeTheme(bool isThemeLight) async {
    await prefManager.setBool(themeKey, isThemeLight);
  }

  static bool getTheme() {
    return prefManager.getBool(themeKey) ?? true;
  }
}
