import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final int fontSize;
  final TextAlign textAlign;
  final Color color;

  const TextWidget(
      {super.key,
      this.textAlign = TextAlign.start,
      required this.text,
      required this.color,
      this.fontFamily,
      this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: TextStyle(
          fontFamily: fontFamily ?? "M400",
          fontSize: fontSize.toDouble(),
          color: color),
    );
  }
}
