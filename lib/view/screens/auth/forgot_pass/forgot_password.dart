import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/assets/icons/app_icons.dart';
import '../../../widgets/buttons/filled_button.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/text/texts.dart';
import '../../../widgets/tf/textfields.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    return Scaffold(
      backgroundColor: themeColor.primary,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.getAuthHPadding(context),
            vertical: ResponsiveSize.getAuthVPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 20),
                width: ResponsiveSize.getAuthTitleWidth(context),
                child: TextWidget(
                    textAlign: TextAlign.left,
                    text: "Forgot Password?",
                    color: themeColor.secondary,
                    fontFamily: "M700",
                    fontSize: ResponsiveSize.getLargeFont(context))),
            SizedBox(
              height: ResponsiveSize.sizedBoxHeight(context),
            ),
            SizedBox(
              height: ResponsiveSize.textFieldHeight(context),
              child: TextFields(
                  fontSize: ResponsiveSize.getSmallFont(context),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor.outline)),
                  prefixImage: Image.asset(
                    AppIcons.email,
                    scale: 2,
                  ),
                  fillColor: themeColor.primaryContainer,
                  fontFamily: "M500",
                  controller: _emailController,
                  hintText: "Enter your email address"),
            ),
            SizedBox(
              height: ResponsiveSize.sizedBoxHeight(context),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                child: RichText(
                    text: TextSpan(
                        text: "* ",
                        style: TextStyle(
                            fontSize:
                                ResponsiveSize.getSmallFont(context).toDouble(),
                            fontFamily: "M400",
                            color: CommonColors.navBarActive),
                        children: [
                      TextSpan(
                          text:
                              "We will send you a message to set or reset your new password",
                          style: TextStyle(
                              fontSize: ResponsiveSize.getSmallFont(context)
                                  .toDouble(),
                              fontFamily: "M400",
                              color: themeColor.tertiary)),
                    ]))),
            SizedBox(height: ResponsiveSize.sizedBoxHeight(context)),
            SizedBox(
                height: ResponsiveSize.buttonHeight(context),
                width: double.infinity,
                child: ColoredButton(
                    text: "Submit",
                    backColor: CommonColors.buttonColor,
                    fontFamily: "M600",
                    event: () {},
                    fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
