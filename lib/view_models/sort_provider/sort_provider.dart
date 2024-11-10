import 'package:flutter/widgets.dart';

class SortProvider extends ChangeNotifier {
  bool isSorted = false;
  bool isCartSorted = false;

  changeSortPref() {
    isSorted = !isSorted;
    notifyListeners();
  }

  changeSortCartPref() {
    isCartSorted = !isCartSorted;
    notifyListeners();
  }
}
