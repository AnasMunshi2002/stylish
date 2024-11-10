class TokenModel {
  String? token;

  TokenModel({required this.token});

  TokenModel.fromJSON(Map<String, dynamic> map) {
    token = map['token'];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }
}
