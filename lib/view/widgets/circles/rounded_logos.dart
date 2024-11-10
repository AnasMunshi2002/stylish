import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/theme_provider/theme.dart';

class RoundedLogos extends StatelessWidget {
  final String image;

  const RoundedLogos({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    return GestureDetector(
        onTap: () {},
        child: Container(
          height: (MediaQuery.of(context).size.width >= 576
              ? (MediaQuery.of(context).size.width * 0.1)
              : (MediaQuery.of(context).size.width * 0.15)),
          width: (MediaQuery.of(context).size.width >= 576
              ? (MediaQuery.of(context).size.width * 0.1)
              : (MediaQuery.of(context).size.width * 0.15)),
          decoration: BoxDecoration(
              border: Border.all(
                  width: (MediaQuery.of(context).size.width >= 576 ? 2 : 1),
                  color: const Color(0xffF83758)),
              borderRadius: BorderRadius.circular(100),
              color: themeColor.tertiary),
          child: Padding(
            padding: EdgeInsets.all(
              (MediaQuery.of(context).size.width * 0.03),
            ),
            child: Image.asset(
              fit: BoxFit.fill,
              image,
              scale: (MediaQuery.of(context).size.width >= 576 ? 2 : 3),
            ),
          ),
        ));
  }
}
