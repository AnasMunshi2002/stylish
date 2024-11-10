import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen {
  static late final SharedPreferences boardingManager;
  static const boardingKey = "BOARDING_KEY";

  static initBoardingPref() async {
    boardingManager = await SharedPreferences.getInstance();
  }

  static Future<void> updateBoarding(bool value) async {
    await boardingManager.setBool(boardingKey, value);
  }

  static bool getBoarding() {
    return boardingManager.getBool(boardingKey) ?? true;
  }
}
