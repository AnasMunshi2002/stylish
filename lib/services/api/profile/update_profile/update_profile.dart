import 'dart:convert';

import 'package:http/http.dart';

import '../../../../models/api_models/user/user.dart';

class UpdateProfileAPI {
  static final UpdateProfileAPI profileAPI = UpdateProfileAPI.internal();
  final String api = "https://fakestoreapi.com/users/1";

  factory UpdateProfileAPI() {
    return profileAPI;
  }

  UpdateProfileAPI.internal();

  Future<User?> updateProfile(User user) async {
    User? respUser;
    try {
      Response response = await put(Uri.parse(api),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "address": {
              "geolocation": {"lat": "-37.3159", "long": "81. "},
              "city": "kilcole",
              "street": "new road",
              "number": 7682,
              "zipcode": "12926-3874"
            },
            "email": "john@gmail.com",
            "password": "m38rmF\$",
            "name": {"firstname": "john", "lastname": "doe"},
            "phone": "1-570-236-7033"
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
