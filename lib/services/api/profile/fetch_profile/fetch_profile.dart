import 'dart:convert';

import 'package:http/http.dart';

import '../../../../models/api_models/user/user.dart';

class FetchProfile {
  static final FetchProfile fetchProfile = FetchProfile.internal();
  final String api = "https://fakestoreapi.com/users/1";

  factory FetchProfile() {
    return fetchProfile;
  }

  FetchProfile.internal();

  Future<User?> getUser() async {
    User? user;
    try {
      Response response = await get(Uri.parse(api));
      if (response.statusCode == 200) {
        user = User.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
    return user;
  }
}
