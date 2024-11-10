
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier{

  int currentIndex =0;

  changePage(int index){
    currentIndex=index;
    notifyListeners();
  }

}