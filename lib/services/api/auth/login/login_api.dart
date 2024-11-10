import 'dart:convert';

import 'package:http/http.dart';

import '../../../../models/api_models/auth/login/login_model.dart';
import '../../../../models/api_models/auth/login_token_model/token.dart';

class LoginAPI {
  static final LoginAPI loginAPI = LoginAPI.internal();
  final String api = 'https://fakestoreapi.com/auth/login';

  factory LoginAPI() {
    return loginAPI;
  }

  LoginAPI.internal();

  Future<TokenModel?> loginGetToken(LoginModel loginCred) async {
    TokenModel? token;
    try {
      Response response = await post(Uri.parse(api), body: {
        'username': loginCred.username,
        'password': loginCred.password
      });
      if (response.statusCode == 200) {
        token = TokenModel(token: jsonDecode(response.body)['token']);
      }
    } catch (e) {
      return null;
    }
    return token;
  }
}
