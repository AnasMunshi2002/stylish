import 'package:flutter/material.dart';

class ClothSizeProvider extends ChangeNotifier {
  String size = "S";

  selectSize(String newSize, price) {
    size = newSize;
    /*switch (size) {
      case "S":

        break;
      case "M":

        break;
      case "L":

        break;
      case "XL":

        break;
      case "XXL":

      default:

        break;
    }*/
    notifyListeners();
  }
}
