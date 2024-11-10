import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/theme_provider/theme.dart';
import '../responsive_size/responsive_size.dart';

class TB extends StatelessWidget {
  final ButtonStyle? style;
  final String text;
  final Color? color;
  final String? weight;
  final Function() event;
  final int? fontSize;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;

  const TB(
      {required this.event,
      required this.text,
      super.key,
      this.fontSize,
      this.weight,
      this.style,
      this.color,
      this.decoration,
      this.decorationStyle,
      this.decorationColor});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return TextButton(
        style: style,
        onPressed: event,
        child: Text(text,
            style: TextStyle(
                decoration: decoration,
                decorationColor: decorationColor,
                decorationStyle: decorationStyle,
                color: color ?? themeColor.inversePrimary,
                fontFamily: weight ?? "M500",
                fontSize: fontSize?.toDouble() ??
                    ResponsiveSize.getSmallFont(context).toDouble())));
  }
}
