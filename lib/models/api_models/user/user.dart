import 'address/address.dart';
import 'name/user_name.dart';

class User {
  Address? address;
  int? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  String? phone;
  int? iV;

  User(
      {this.address,
      this.id,
      this.email,
      this.username,
      this.password,
      this.name,
      this.phone,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    id = json['id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    phone = json['phone'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['phone'] = phone;
    data['__v'] = iV;
    return data;
  }
}
