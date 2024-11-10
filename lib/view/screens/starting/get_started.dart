import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../view_models/navigation_provider/navigation_provider.dart';
import '../../../view_models/page_view_provider/page_view_provider.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../../widgets/assets/images/app_images.dart';
import '../../widgets/buttons/filled_button.dart';
import '../../widgets/text/texts.dart';
import '../auth/login/login.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                AppImages.getStarted,
                fit: BoxFit.cover,
              )),
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 37, right: 37),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(0, 0, 0, 63),
                Color(0xff00000000),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextWidget(
                        textAlign: TextAlign.center,
                        text: "You want Authentic, here you go!",
                        fontFamily: "M600",
                        color: themeColor.onPrimaryContainer,
                        fontSize:
                            (MediaQuery.of(context).size.width * 0.09).toInt(),
                      ),
                      TextWidget(
                        text: "Find it here, buy it now!",
                        fontSize:
                            (MediaQuery.of(context).size.width * 0.05).toInt(),
                        fontFamily: "M400",
                        color: themeColor.onPrimaryContainer,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ColoredButton(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              text: "Get Started",
                              backColor: themeColor.inversePrimary,
                              fontFamily: "M600",
                              event: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                                context.read<PageViewProvider>().pageNo = 0;
                                context
                                    .read<NavigationProvider>()
                                    .changePage(0);
                              },
                              fontSize: 23)),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewPadding.bottom))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
