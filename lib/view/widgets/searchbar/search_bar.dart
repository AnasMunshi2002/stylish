import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/theme_provider/theme.dart';
import '../assets/icons/app_icons.dart';
import '../responsive_size/responsive_size.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;

  const SearchBox({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return SearchBar(
      textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: ResponsiveSize.getMediumFont(context).toDouble(),
          color: themeColor.onSecondary)),
      controller: controller,
      elevation: const WidgetStatePropertyAll(6),
      trailing: [
        IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {},
          icon: Image.asset(
            AppIcons.mic,
            color: themeColor.onSecondary,
            scale: ResponsiveSize.getScale(context),
          ),
        )
      ],
      leading: Image.asset(
        "assets/icons/Component 52.png",
        color: themeColor.onSecondary,
        scale: ResponsiveSize.getScale(context),
      ),
      backgroundColor: WidgetStatePropertyAll(themeColor.onPrimaryContainer),
      hintText: "Search any Product..",
      hintStyle: const WidgetStatePropertyAll(
          TextStyle(fontFamily: "M400", color: Color(0xffAABBBf))),
      shape: WidgetStatePropertyAll(
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(6))),
    );
  }
}
