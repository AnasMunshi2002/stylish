import '../../../api_models/cart/cart_api_model/product.dart';

class CartProduct {
  int? id;
  int? userId;
  String? date;
  List<Products>? products;
  int? iV;

  CartProduct({this.id, this.userId, this.date, this.products, this.iV});

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}
