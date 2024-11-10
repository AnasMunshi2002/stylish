import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final String text;
  final String fontFamily;
  final VoidCallback event;
  final int borderRadius;
  final Color backColor;
  final int fontSize;
  final Color fontColor;
  final EdgeInsets? padding;

  const ColoredButton(
      {this.fontColor = Colors.white,
      this.padding,
      this.borderRadius = 10,
      super.key,
      required this.text,
      required this.backColor,
      required this.fontFamily,
      required this.event,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    // final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return FilledButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(padding),
          shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.toDouble()))),
          backgroundColor: WidgetStatePropertyAll(backColor),
        ),
        onPressed: event,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSize.toDouble(),
              color: fontColor),
        ));
  }
}
