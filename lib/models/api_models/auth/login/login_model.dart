class LoginModel {
  String? username;
  String? password;

  LoginModel({required this.password, required this.username});

  LoginModel.fromJSON(Map<String, dynamic> map) {
    username = map['username'];
    password = map['password'];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}
