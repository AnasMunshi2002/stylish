import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../services/shared_pref/login/login_pref_manager.dart';
import '../../../services/shared_pref/on_boarding_screen/on_boarding_screen.dart';
import '../../../view_models/navigation_provider/navigation_provider.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../auth/login/login.dart';
import '../main_pages/home/home_page.dart';
import '../welcome/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    exitSplash(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarBrightness: themeColor.brightness),
      child: Scaffold(
        backgroundColor: themeColor.primary,
        body: Center(
          child: Image.asset("assets/logo/logoipsum-255 1.png"),
        ),
      ),
    );
  }

  exitSplash(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) {
      if (!OnBoardingScreen.getBoarding()) {
        if (LoginManager.getIsLogin()) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
          context.read<NavigationProvider>().changePage(0);
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Welcome()));
      }
    }
  }
}
