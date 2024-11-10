import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static late final SharedPreferences loginPrefManager;
  static String isLoginKey = "LOGIN_KEY";
  static String tokenKey = "TOKEN_KEY";

  static initPref() async {
    loginPrefManager = await SharedPreferences.getInstance();
  }

  static loginUpdate(bool isLoggedIn, String? token) async {
    await loginPrefManager.setBool(isLoginKey, isLoggedIn);
    await loginPrefManager.setString(tokenKey, token ?? "");
  }

  static bool getIsLogin() {
    return loginPrefManager.getBool(isLoginKey) ?? false;
  }

  static String? getToken() {
    return loginPrefManager.getString(tokenKey);
  }
}
