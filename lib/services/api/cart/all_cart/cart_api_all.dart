import 'dart:convert';

import 'package:http/http.dart';

import '../../../../models/api_models/cart/cart_api_model/cart_api_model.dart';

class AllCartAPI {
  static final AllCartAPI cartAPI = AllCartAPI.internal();
  final String api = "https://fakestoreapi.com/carts/user/1";
  final String addApi = "https://fakestoreapi.com/carts";

  factory AllCartAPI() {
    return cartAPI;
  }

  AllCartAPI.internal();

  Future<List<CartProduct>?> getCartProducts() async {
    List<CartProduct>? cart;
    try {
      Response response = await get(Uri.parse(api));
      if (response.statusCode == 200) {
        List ls = jsonDecode(response.body);
        cart = List.generate(
            ls.length, (index) => CartProduct.fromJson(ls[index]));
      }
    } catch (e) {
      return null;
    }
    return cart;
  }

  Future<CartProduct?>? addToCart(CartProduct cart) async {
    CartProduct? result;
    try {
      Response response = await post(Uri.parse(addApi),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "userId": 1,
            "date": cart.date,
            "products": [
              {
                "productId": cart.products![0].productId,
                "quantity": cart.products![0].quantity
              },
            ]
          }));
      if (response.statusCode == 200) {
        result = CartProduct.fromJson(jsonDecode(response.body));
        print("request : ${cart.id} ; ${cart.date}");
        print("response : ${result.date} ; ${result.id}");
      }
    } catch (e) {
      return null;
    }
    return result;
  }

  Future<CartProduct?> deleteCart(CartProduct cart) async {
    CartProduct? result;
    try {
      Response response = await delete(Uri.parse("$addApi/${cart.id}"));
      if (response.statusCode == 200) {
        result = CartProduct.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      return null;
    }
    return result;
  }

  Future<CartProduct?> updateCart(CartProduct cart) async {
    CartProduct? result;
    try {
      Response response = await put(Uri.parse("$addApi/${cart.id}"));
      if (response.statusCode == 200) {
        result = CartProduct.fromJson(jsonDecode(response.body));
        print(result.id);
      }
    } catch (e) {
      return null;
    }
    return result;
  }
}
