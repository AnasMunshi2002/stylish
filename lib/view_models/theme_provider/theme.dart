import 'package:flutter/material.dart';

import '../../services/shared_pref/theme_store/theme_pref.dart';
import 'colors/common.dart';

class ThemeProvider extends ChangeNotifier {
  bool isThemeLight = ThemePrefManager.getTheme();

  final ThemeData lightTheme = ThemeData(
      textSelectionTheme:
          TextSelectionThemeData(selectionColor: Colors.purple.shade100),
      colorScheme: ColorScheme.light(
        primaryFixed: Colors.white70,
        brightness: Brightness.light,
        primary: Colors.white,
        onPrimary: const Color(0xffFDFDFD),
        secondary: Colors.black,
        secondaryFixed: CommonColors.appBarTitle,
        onSecondary: Colors.black54,
        tertiary: Colors.grey,
        onPrimaryContainer: Colors.grey.shade100,
        outline: const Color(0xffA8A8A9),
        primaryContainer: const Color(0xffF3F3F3),
        inversePrimary: CommonColors.buttonColor,
      ));

  late ThemeData currentTheme = isThemeLight ? lightTheme : darkTheme;

  final ThemeData darkTheme = ThemeData(
      textSelectionTheme:
          TextSelectionThemeData(selectionColor: Colors.purple.shade100),
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        inversePrimary: CommonColors.buttonColor,
        primaryFixed: Colors.grey.shade500,
        primary: Colors.grey.shade800,
        onPrimary: Colors.black87,
        secondary: Colors.white,
        secondaryFixed: CommonColors.appBarTitle,
        onSecondary: Colors.black54,
        tertiary: Colors.white70,
        onPrimaryContainer: Colors.grey.shade200,
        outline: const Color(0xffA8A8A9),
        primaryContainer: const Color(0xffF3F3F3),
      ));

  toggleTheme() {
    if (currentTheme == lightTheme) {
      currentTheme = darkTheme;
    } else {
      currentTheme = lightTheme;
    }
    isThemeLight = !isThemeLight;
    notifyListeners();
  }
}
