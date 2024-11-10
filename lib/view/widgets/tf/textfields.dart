import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/theme_provider/theme.dart';

class TextFields extends StatelessWidget {
  final int fontSize;
  final String hintText;
  final bool hidePass;
  final String fontFamily;
  final Color fillColor;
  final Widget? prefixImage;
  final Widget? suffixImage;
  final int scale;
  final InputBorder border;
  final TextInputType keyboardType;
  final String? errorMsg;
  final TextEditingController controller;

  const TextFields(
      {this.fontSize = 14,
      this.errorMsg,
      super.key,
      this.suffixImage,
      this.border = const OutlineInputBorder(),
      this.scale = 2,
      this.prefixImage,
      required this.fillColor,
      required this.fontFamily,
      this.hidePass = false,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return TextField(
      cursorColor: Colors.pink,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: hidePass,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize.toDouble(),
          color: themeColor.onSecondary),
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87)),
          errorText: errorMsg,
          suffixIcon: suffixImage,
          hintStyle: TextStyle(
            color: themeColor.onSecondary,
            fontFamily: fontFamily,
            fontSize: (MediaQuery.of(context).size.width >= 576
                ? (MediaQuery.of(context).size.width * 0.024)
                : (MediaQuery.of(context).size.width * 0.037)),
          ),
          hintText: hintText,
          fillColor: fillColor,
          filled: true,
          prefixIcon: prefixImage,
          border: border),
    );
  }
}
