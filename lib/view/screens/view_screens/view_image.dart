import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/theme_provider/theme.dart';
import '../../widgets/responsive_size/responsive_size.dart';

class ViewImage extends StatelessWidget {
  final String image;

  const ViewImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: IconButton(
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(CircleBorder()),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/icons/Vector 3.png",
                color: themeColor.secondary,
                scale: ResponsiveSize.getScale(context),
              )),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: Hero(
              tag: "imageHero",
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              )),
        ),
      ),
    );
  }
}
