import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  int size = 7;
  double price = 1500;

  decreaseCount(int count) {
    if (count != 0) {
      count--;
    }
    print(count);
    notifyListeners();
  }

  increaseCount(int count) {
    count++;
    print(count);
    notifyListeners();
  }

  selectSize(int number) {
    size = number;
    switch (size) {
      case 6:
        price = 1400;
        break;
      case 7:
        price = 1500;
        break;
      case 8:
        price = 1600;
        break;
      case 9:
        price = 1700;
        break;
      case 10:
        price = 1800;
        break;
      default:
        price = 2000;
        break;
    }
    notifyListeners();
  }
}
