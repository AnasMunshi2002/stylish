import 'dart:convert';

import 'package:http/http.dart';

import '../../../../models/api_models/cart/cart_api_model/cart_api_model.dart';

class SortCartAPI {
  static final SortCartAPI sortApi = SortCartAPI.internal();
  final String api = "https://fakestoreapi.com/carts?sort=";

  factory SortCartAPI() {
    return sortApi;
  }

  SortCartAPI.internal();

  Future<List<CartProduct>?> getSortedCartProduct(String type) async {
    List<CartProduct>? result;

    try {
      Response response = await get(Uri.parse("$api$type"));
      if (response.statusCode == 200) {
        List ls = jsonDecode(response.body);
        result = List.generate(
            ls.length, (index) => CartProduct.fromJson(ls[index]));
        print("Cart Sort");
      }
    } catch (e) {
      return null;
    }
    return result;
  }
}
