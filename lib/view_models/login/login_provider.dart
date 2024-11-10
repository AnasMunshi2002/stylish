import 'package:flutter/material.dart';

import '../../models/api_models/auth/login/login_model.dart';
import '../../models/api_models/auth/login_token_model/token.dart';
import '../../services/api/auth/login/login_api.dart';
import '../../services/shared_pref/login/login_pref_manager.dart';
import '../../services/shared_pref/on_boarding_screen/on_boarding_screen.dart';
import '../../view/screens/main_pages/home/home_page.dart';
import '../theme_provider/colors/common.dart';

class LoginProvider extends ChangeNotifier {
  bool isShown = false;

  bool isConfPassShown = false;
  TokenModel? tokenModel;

  changeView() {
    if (isShown) {
      isShown = false;
    } else {
      isShown = true;
    }
    notifyListeners();
  }

  changeViewConfPass() {
    if (isConfPassShown) {
      isConfPassShown = false;
    } else {
      isConfPassShown = true;
    }
    notifyListeners();
  }

  Future<void> validateForm(
      String username, String password, BuildContext context) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      LoginAPI loginAPI = LoginAPI();
      tokenModel = await loginAPI
          .loginGetToken(LoginModel(password: password, username: username));
      if (context.mounted) {
        if (tokenModel?.token != null) {
          LoginManager.loginUpdate(true, tokenModel!.token!);
          if (OnBoardingScreen.getBoarding()) {
            Navigator.pop(context);
          }
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
          OnBoardingScreen.updateBoarding(false);
        } else {
          const snackBar = SnackBar(
            content: Text(
              "INVALID USERNAME OR PASSWORD",
              style: TextStyle(color: CommonColors.whiteC),
            ),
            backgroundColor: CommonColors.navBarActive,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      const snackBar = SnackBar(
        content: Text(
          "Username or Password cannot be empty",
          style: TextStyle(color: CommonColors.whiteC),
        ),
        backgroundColor: CommonColors.navBarActive,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    notifyListeners();
  }
}
