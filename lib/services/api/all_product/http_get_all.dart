import 'dart:convert';

import 'package:http/http.dart';

import '../../../models/api_models/all_products/all_products.dart';

class HttpGetAll {
  final String api = "https://fakestoreapi.com/products";
  static final HttpGetAll httpPref = HttpGetAll.internal();

  factory HttpGetAll() {
    return httpPref;
  }

  HttpGetAll.internal();

  Future<List<AllProducts>> getProducts() async {
    List<AllProducts> list = [];
    try {
      Response response = await get(Uri.parse(api));
      if (response.statusCode == 200) {
        List<dynamic> ls = jsonDecode(response.body);
        list = List.generate(
            ls.length, (index) => AllProducts.fromJson(ls[index]));
      } else {
        list = [];
      }
    } catch (e) {
      return [];
    }
    return list;
  }
}
