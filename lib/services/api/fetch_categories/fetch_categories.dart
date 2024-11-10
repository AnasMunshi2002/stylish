import 'dart:convert';

import 'package:http/http.dart';

import '../../../models/api_models/all_products/all_products.dart';

class FetchCategories {
  final String api = "https://fakestoreapi.com/products/categories";

  static final FetchCategories fetchCategories = FetchCategories.internal();

  factory FetchCategories() {
    return fetchCategories;
  }

  FetchCategories.internal();

  Future<List?> getCategories() async {
    List categories = [];
    try {
      Response response = await get(Uri.parse(api));
      if (response.statusCode == 200) {
        categories = jsonDecode(response.body);
      } else {
        categories = [];
      }
    } catch (e) {
      return [];
    }
    return categories;
  }

  Future<List<AllProducts>> getCategoryProducts(String category) async {
    List<AllProducts> list = [];
    try {
      Response response = await get(
          Uri.parse("https://fakestoreapi.com/products/category/$category"));
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
