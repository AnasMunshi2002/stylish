import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';

class ProductTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Function(String) event;
  final TextInputType inputType;

  const ProductTextField(
      {required this.hint,
      required this.event,
      required this.inputType,
      required this.controller,
      super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return TextField(
      keyboardType: inputType,
      onChanged: event,
      controller: controller,
      cursorColor: CommonColors.buttonColor,
      style: TextStyle(fontFamily: "M500", color: themeColor.onSecondary),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87)),
        hintStyle: TextStyle(
          color: themeColor.onSecondary,
          fontFamily: "M400",
          fontSize: (MediaQuery.of(context).size.width >= 576
              ? (MediaQuery.of(context).size.width * 0.024)
              : (MediaQuery.of(context).size.width * 0.037)),
        ),
        hintText: hint,
        fillColor: CommonColors.whiteC,
        filled: true,
      ),
    );
  }
}
