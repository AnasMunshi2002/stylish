import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/login/login_provider.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/assets/icons/app_icons.dart';
import '../../../widgets/buttons/filled_button.dart';
import '../../../widgets/login_with/login_with.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/tb/tb.dart';
import '../../../widgets/text/texts.dart';
import '../../../widgets/tf/textfields.dart';
import '../forgot_pass/forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: themeColor.primary,
      body: SingleChildScrollView(
        child: Container(
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
                      text: "Welcome Back!",
                      color: themeColor.secondary,
                      fontFamily: "M700",
                      fontSize: ResponsiveSize.getLargeFont(context))),
              SizedBox(height: ResponsiveSize.sizedBoxHeight(context)),
              SizedBox(
                  height: ResponsiveSize.textFieldHeight(context),
                  child: TextFields(
                      controller: _usernameController,
                      fillColor: themeColor.primaryContainer,
                      hintText: "Username or email",
                      prefixImage: Image.asset(AppIcons.person, scale: 2),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: themeColor.outline)),
                      fontFamily: 'M500',
                      fontSize: ResponsiveSize.getSmallFont(context))),
              SizedBox(height: ResponsiveSize.sizedBoxHeight(context)),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                SizedBox(
                    height: ResponsiveSize.textFieldHeight(context),
                    child: TextFields(
                        hidePass: loginProvider.isShown,
                        controller: _passwordController,
                        fontFamily: "M500",
                        fillColor: themeColor.primaryContainer,
                        hintText: "Password",
                        prefixImage: Image.asset(AppIcons.password, scale: 2),
                        fontSize: ResponsiveSize.getSmallFont(context),
                        suffixImage: IconButton(
                            onPressed: () {
                              loginProvider.changeView();
                            },
                            icon: !loginProvider.isShown
                                ? Image.asset(AppIcons.eyeShow, scale: 2)
                                : Icon(Icons.visibility_off,
                                    color: themeColor.onSecondary)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: themeColor.outline)))),
                TB(
                    style: ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(
                            themeColor.onPrimaryContainer)),
                    event: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    text: "Forgot Password?"),
                SizedBox(height: (MediaQuery.of(context).size.width * 0.04)),
                SizedBox(
                    height: ResponsiveSize.buttonHeight(context),
                    width: double.maxFinite,
                    child: ColoredButton(
                      text: "Login",
                      backColor: themeColor.inversePrimary,
                      fontFamily: "M600",
                      event: () {
                        String username = _usernameController.text.toString();
                        String password = _passwordController.text.toString();

                        loginProvider.validateForm(username, password, context);
                      },
                      fontSize: ResponsiveSize.getTitleFont(context),
                    )),
                SizedBox(
                    height: (MediaQuery.of(context).size.width >= 576
                        ? (MediaQuery.of(context).size.width * 0.2)
                        : (MediaQuery.of(context).size.width * 0.08))),
                const LoginWith(
                    bottomText: "Create an account ", isSignupPage: false)
              ])
            ],
          ),
        ),
      ),
    );
  }
}
