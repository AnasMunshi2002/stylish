import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/theme_provider/theme.dart';
import '../../screens/auth/login/login.dart';
import '../../screens/auth/signup/signup.dart';
import '../assets/icons/app_icons.dart';
import '../circles/rounded_logos.dart';
import '../responsive_size/responsive_size.dart';
import '../text/texts.dart';

class LoginWith extends StatelessWidget {
  final String bottomText;
  final bool isSignupPage;

  const LoginWith(
      {super.key, required this.bottomText, required this.isSignupPage});

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    return Center(
        child: SizedBox(
            width: (MediaQuery.of(context).size.width >= 576
                ? (MediaQuery.of(context).size.width * 0.5)
                : (MediaQuery.of(context).size.width * 0.65)),
            child: Column(children: [
              TextWidget(
                  text: "- OR Continue with -",
                  color: themeColor.secondary,
                  fontFamily: "M500",
                  fontSize: ResponsiveSize.getSmallFont(context)),
              const SizedBox(height: 15),
              SizedBox(
                  width: (MediaQuery.of(context).size.width >= 576
                      ? (MediaQuery.of(context).size.width * 0.4)
                      : (MediaQuery.of(context).size.width * 0.65)),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RoundedLogos(image: AppIcons.google),
                        RoundedLogos(image: AppIcons.apple),
                        RoundedLogos(image: AppIcons.facebook)
                      ])),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextWidget(
                    text: bottomText,
                    color: themeColor.secondary,
                    fontFamily: "M400",
                    fontSize: ResponsiveSize.getSmallFont(context)),
                GestureDetector(
                    onTap: () {
                      if (isSignupPage) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      }
                    },
                    child: Text(isSignupPage ? "Login" : "Sign up",
                        style: TextStyle(
                            fontSize:
                                ResponsiveSize.getSmallFont(context).toDouble(),
                            decoration: TextDecoration.underline,
                            decorationColor: themeColor.inversePrimary,
                            fontFamily: "M600",
                            color: themeColor.inversePrimary)))
              ]),
              const SizedBox(height: 20)
            ])));
  }
}
