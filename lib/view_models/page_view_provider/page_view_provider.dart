import 'package:flutter/material.dart';

class PageViewProvider extends ChangeNotifier {
  int pageNo = 0;
  double offset1 = 0;
  double offset2 = 0;

  changePage(int index) {
    pageNo = index;
    notifyListeners();
  }

  changeOffset(double newOffset, int choice) {
    choice == 1 ? (offset1 = newOffset) : (offset2 = newOffset);
    notifyListeners();
  }
}
