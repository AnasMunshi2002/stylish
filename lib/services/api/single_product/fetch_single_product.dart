import 'dart:convert';

import 'package:http/http.dart';

import '../../../models/api_models/all_products/all_products.dart';

class FetchSingleProduct {
  static final FetchSingleProduct fetch = FetchSingleProduct.internal();
  final String api = "https://fakestoreapi.com/products/";

  factory FetchSingleProduct() {
    return fetch;
  }

  FetchSingleProduct.internal();

  Future<AllProducts?> getProduct(int id) async {
    AllProducts? product;
    try {
      Response response = await get(Uri.parse("$api$id"));
      if (response.statusCode == 200) {
        product = AllProducts.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
    return product;
  }
}
