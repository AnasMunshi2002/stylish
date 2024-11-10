import 'package:flutter/material.dart';

class AddProductProvider extends ChangeNotifier {
  int fieldsCompleted = 0;
  double progress = 0.0;
  String category = "";

  initProgress() {
    progress = 0.0;
    fieldsCompleted = 0;
    category = "";
    notifyListeners();
  }

  changeCategory(String select) {
    category = select;
    notifyListeners();
  }

  increaseField() {
    fieldsCompleted++;
    progress = progress + 0.2;
    notifyListeners();
  }

  decreaseField() {
    fieldsCompleted--;
    progress = progress - 0.2;
    notifyListeners();
  }
}
