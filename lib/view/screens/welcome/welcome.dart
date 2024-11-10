import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../services/shared_pref/login/login_pref_manager.dart';
import '../../../view_models/navigation_provider/navigation_provider.dart';
import '../../../view_models/page_view_provider/page_view_provider.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../../widgets/responsive_size/responsive_size.dart';
import '../../widgets/tb/tb.dart';
import '../../widgets/text/texts.dart';
import '../../widgets/welcome_page_view/welcome_body.dart';
import '../main_pages/home/home_page.dart';
import '../starting/get_started.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return Scaffold(
        backgroundColor: themeColor.primary,
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: themeColor.brightness,
                statusBarIconBrightness:
                    themeColor.brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark),
            leadingWidth: double.maxFinite,
            backgroundColor: themeColor.primary,
            leading: Row(children: [
              const SizedBox(width: 15),
              TextWidget(
                  text: "${context.watch<PageViewProvider>().pageNo + 1}/",
                  color: themeColor.secondary,
                  fontSize: ResponsiveSize.getMediumFont(context)),
              TextWidget(
                  text: "3",
                  color: themeColor.tertiary,
                  fontSize: ResponsiveSize.getMediumFont(context))
            ]),
            actions: [
              TB(
                event: () {
                  if (LoginManager.getIsLogin()) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                    context.read<NavigationProvider>().changePage(0);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GetStartedScreen()));
                  }
                },
                text: "Skip",
                weight: "M800",
                fontSize: ResponsiveSize.getMediumFont(context),
                color: themeColor.secondary,
              )
            ]),
        body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width >= 576 ? 20 : 10),
            height: MediaQuery.of(context).size.height >= 700
                ? (MediaQuery.of(context).size.height >= 1000
                    ? MediaQuery.of(context).size.height * 0.92
                    : MediaQuery.of(context).size.height * 0.83)
                : MediaQuery.of(context).size.height * 0.9,
            width: double.maxFinite,
            child: const WelcomeBody()));
  }
}
