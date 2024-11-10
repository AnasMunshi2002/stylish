import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/api_models/user/user.dart';
import '../../../../services/api/auth/signup/signup_api.dart';
import '../../../../view_models/login/login_provider.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/assets/icons/app_icons.dart';
import '../../../widgets/buttons/filled_button.dart';
import '../../../widgets/login_with/login_with.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/text/texts.dart';
import '../../../widgets/tf/textfields.dart';
import '../../main_pages/home/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confPasswordController = TextEditingController();
  SignUpAPI signupAPI = SignUpAPI();

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
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
                  color: themeColor.secondary,
                  textAlign: TextAlign.left,
                  text: "Create an Account",
                  fontFamily: "M700",
                  fontSize: ResponsiveSize.getLargeFont(context),
                ),
              ),
              SizedBox(height: ResponsiveSize.sizedBoxHeight(context)),
              SizedBox(
                height: ResponsiveSize.textFieldHeight(context),
                child: TextFields(
                    fontSize: ResponsiveSize.getSmallFont(context),
                    controller: _usernameController,
                    fontFamily: "M500",
                    fillColor: themeColor.primaryContainer,
                    hintText: "Username",
                    prefixImage: Image.asset(
                      AppIcons.person,
                      scale: 2,
                    ),
                    keyboardType: TextInputType.text,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor.outline))),
              ),
              SizedBox(
                height: ResponsiveSize.sizedBoxHeight(context),
              ),
              SizedBox(
                height: ResponsiveSize.textFieldHeight(context),
                child: TextFields(
                    fontSize: ResponsiveSize.getSmallFont(context),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    fontFamily: "M500",
                    fillColor: themeColor.primaryContainer,
                    hintText: "Email",
                    prefixImage: Image.asset(
                      AppIcons.email,
                      scale: 2,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor.outline))),
              ),
              SizedBox(
                height: ResponsiveSize.sizedBoxHeight(context),
              ),
              SizedBox(
                height: ResponsiveSize.textFieldHeight(context),
                child: TextFields(
                    fontSize: ResponsiveSize.getSmallFont(context),
                    hidePass: !context.watch<LoginProvider>().isShown,
                    controller: _passwordController,
                    fontFamily: "M500",
                    fillColor: themeColor.primaryContainer,
                    hintText: "Password",
                    prefixImage: Image.asset(
                      AppIcons.password,
                      scale: 2,
                    ),
                    suffixImage: IconButton(
                        onPressed: () =>
                            context.read<LoginProvider>().changeView(),
                        icon: context.watch<LoginProvider>().isShown
                            ? Image.asset(
                                AppIcons.eyeShow,
                                scale: 2,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: themeColor.onSecondary,
                              )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor.outline))),
              ),
              SizedBox(
                height: ResponsiveSize.sizedBoxHeight(context),
              ),
              SizedBox(
                height: ResponsiveSize.textFieldHeight(context),
                child: TextFields(
                    hidePass: !context.watch<LoginProvider>().isConfPassShown,
                    controller: _confPasswordController,
                    fontFamily: "M500",
                    fillColor: themeColor.primaryContainer,
                    hintText: "Confirm Password",
                    prefixImage: Image.asset(
                      AppIcons.password,
                      scale: 2,
                    ),
                    suffixImage: IconButton(
                        onPressed: () {
                          context.read<LoginProvider>().changeViewConfPass();
                        },
                        icon: context.watch<LoginProvider>().isConfPassShown
                            ? Image.asset(
                                AppIcons.eyeShow,
                                scale: 2,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: themeColor.onSecondary,
                              )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor.outline))),
              ),
              SizedBox(
                height: ResponsiveSize.sizedBoxHeight(context) * 0.1,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 15),
                  child: RichText(
                      text: TextSpan(
                          text: "By clicking the ",
                          style: TextStyle(
                              fontSize: ResponsiveSize.getSmallFont(context)
                                  .toDouble(),
                              fontFamily: "M400",
                              color: themeColor.tertiary),
                          children: [
                        TextSpan(
                            text: "Register",
                            style: TextStyle(
                                fontSize: ResponsiveSize.getSmallFont(context)
                                    .toDouble(),
                                fontFamily: "M400",
                                color: themeColor.inversePrimary)),
                        const TextSpan(
                            text: " button, you agree to the public offer")
                      ]))),
              SizedBox(
                height: ResponsiveSize.sizedBoxHeight(context) * 0.5,
              ),
              SizedBox(
                height: ResponsiveSize.buttonHeight(context),
                width: double.infinity,
                child: ColoredButton(
                    borderRadius: 10,
                    backColor: CommonColors.buttonColor,
                    event: () async {
                      String username = _usernameController.text.toString();
                      String email = _emailController.text.toString();
                      String? password = _passwordController.text ==
                              _confPasswordController.text
                          ? _passwordController.text.toString()
                          : null;
                      User user = User(
                          email: email, username: username, password: password);
                      if (username.isNotEmpty &&
                          email.isNotEmpty &&
                          password != null) {
                        User? respUser = await signupAPI.createUser(user);
                        if (respUser != null) {
                          const snackBar = SnackBar(
                            content: Text(
                              "Successfully User Created",
                              style: TextStyle(color: CommonColors.whiteC),
                            ),
                            backgroundColor: Colors.green,
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        }
                      } else {}
                    },
                    text: "Create Account",
                    fontFamily: "M600",
                    fontSize: 20),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.width >= 576
                    ? (MediaQuery.of(context).size.width * 0.14)
                    : (MediaQuery.of(context).size.width * 0.04)),
              ),
              const LoginWith(
                bottomText: "I Already Have an account ",
                isSignupPage: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
