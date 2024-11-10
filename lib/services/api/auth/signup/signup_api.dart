import 'dart:convert';

import 'package:http/http.dart';

import '../../../../models/api_models/user/user.dart';

class SignUpAPI {
  static final SignUpAPI signUpAPI = SignUpAPI.internal();
  final String api = "https://fakestoreapi.com/users";

  factory SignUpAPI() {
    return signUpAPI;
  }

  SignUpAPI.internal();

  Future<User?> createUser(User user) async {
    User? respUser;
    try {
      Response response = await post(Uri.parse(api),
          body: jsonEncode({
            'email': user.email,
            'username': user.username,
            'password': user.password,
            'name': {'firstname': 'John', 'lastname': 'Doe'},
            'address': {
              'geolocation': {'lat': '-37.3159', "long": '81.1496'},
              'city': 'kilcoole',
              'street': 'new road',
              'number': 7682,
              'zipcode': '12926-3874'
            },
            'phone': '+91-9965287336'
          }));
      if (response.statusCode == 200) {
        respUser = User.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
    return respUser;
  }
}
