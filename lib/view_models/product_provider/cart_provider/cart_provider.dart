import 'package:flutter/widgets.dart';

import '../../../models/api_models/cart/cart_api_model/cart_api_model.dart';
import '../../../services/api/cart/all_cart/cart_api_all.dart';
import '../../../services/api/cart/sort_cart/sort_cart_api.dart';

class CartProvider extends ChangeNotifier {
  List<CartProduct> cartItems = [];
  final AllCartAPI cartAPI = AllCartAPI();
  SortCartAPI sortCart = SortCartAPI();

  /*Future<List<CartProduct>> fetchAllCartItems() async {
    cartItems = await cartAPI.getCartProducts() ?? [];
    notifyListeners();
    return cartItems;
  }

  Future<List<CartProduct>> fetchSortedCartItems() async {
    cartItems = await sortCart.getSortedCartProduct("desc") ?? [];
    notifyListeners();
    return cartItems;
  }*/

  void updateQuantity(int id, int newQuantity, int prodId) {
    final item = cartItems.firstWhere((item) => item.id == id);
    int index =
        item.products!.indexWhere((element) => element.productId == prodId);
    if (newQuantity >= 0) {
      item.products![index].quantity = newQuantity;
    }
    notifyListeners();
  }
}
