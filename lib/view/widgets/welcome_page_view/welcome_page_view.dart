import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/theme_provider/theme.dart';
import '../responsive_size/responsive_size.dart';
import '../text/texts.dart';

class WelcomePageView extends StatelessWidget {
  final String image;
  final String title;
  final String? content;

  const WelcomePageView(
      {required this.image,
      required this.title,
      this.content =
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
      super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset(image, fit: BoxFit.fitWidth)),
          SizedBox(
              height: (MediaQuery.of(context).size.width >= 576
                  ? (MediaQuery.of(context).size.width * 0.04)
                  : (MediaQuery.of(context).size.width * 0.05))),
          TextWidget(
              color: themeColor.secondary,
              text: title,
              fontFamily: "M800",
              fontSize: ResponsiveSize.getTitleFont(context)),
          Padding(
              padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width >= 576 ? 20 : 0),
                  right: (MediaQuery.of(context).size.width >= 576 ? 20 : 0),
                  top: (MediaQuery.of(context).size.width >= 576 ? 20 : 0)),
              child: TextWidget(
                  color: themeColor.secondary,
                  textAlign: TextAlign.center,
                  text:
                      "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
                  fontFamily: "M400",
                  fontSize: ResponsiveSize.getSmallFont(context)))
        ]);
  }
}
