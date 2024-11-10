import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/theme_provider/theme.dart';
import '../assets/icons/app_icons.dart';
import '../responsive_size/responsive_size.dart';
import '../text/texts.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.read<ThemeProvider>().currentTheme.colorScheme;
    return SizedBox(
      height: ResponsiveSize.sortButtonHeight(context),
      width: ResponsiveSize.sortButtonWidth(context),
      child: FilledButton(
          style: ButtonStyle(
              padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
              elevation: const WidgetStatePropertyAll(3),
              backgroundColor: WidgetStatePropertyAll(themeColor.primary),
              shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(6)))),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                  text: "Filter",
                  fontFamily: "M500",
                  fontSize: ResponsiveSize.getSmallFont(context),
                  color: themeColor.secondary),
              Image.asset(
                AppIcons.filter,
                scale: 2,
                color: themeColor.secondary,
              )
            ],
          )),
    );
  }
}
