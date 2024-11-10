import '../Geolocation/geolocation.dart';

class Address {
  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  Address(
      {this.geolocation, this.city, this.street, this.number, this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    geolocation = json['geolocation'] != null
        ? Geolocation.fromJson(json['geolocation'])
        : null;
    city = json['city'];
    street = json['street'];
    number = json['number'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (geolocation != null) {
      data['geolocation'] = geolocation!.toJson();
    }
    data['city'] = city;
    data['street'] = street;
    data['number'] = number;
    data['zipcode'] = zipcode;
    return data;
  }
}
