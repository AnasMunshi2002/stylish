import 'dart:convert';

import 'package:http/http.dart';

import '../../../../models/api_models/all_products/all_products.dart';

class AddProductAPI {
  static final AddProductAPI addProduct = AddProductAPI.internal();

  final String api = "https://fakestoreapi.com/products";

  factory AddProductAPI() {
    return addProduct;
  }

  AddProductAPI.internal();

  Future<AllProducts?> addProductMethod(AllProducts product) async {
    AllProducts? resProduct;
    try {
      Response response = await post(Uri.parse(api),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "title": product.title,
            "price": product.price,
            "description": product.description,
            "image": product.image,
            "category": product.category
          }));
      if (response.statusCode == 200) {
        resProduct = AllProducts.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
    return resProduct;
  }

  Future<AllProducts?> updateProductMethod(AllProducts product) async {
    AllProducts? result;
    try {
      Response response = await put(Uri.parse("$api/${product.id}"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "title": product.title,
            "price": product.price,
            "description": product.description,
            "image": product.image,
            "category": product.category
          }));
      if (response.statusCode == 200) {
        result = AllProducts.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
    return result;
  }

  Future<AllProducts?> deleteProduct(AllProducts product) async {
    AllProducts? result;
    try {
      Response response = await delete(Uri.parse("$api/${product.id}"));
      if (response.statusCode == 200) {
        result = AllProducts.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
    return result;
  }
}
