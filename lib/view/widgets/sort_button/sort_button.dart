import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/navigation_provider/navigation_provider.dart';
import '../../../view_models/sort_provider/sort_provider.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../assets/icons/app_icons.dart';
import '../responsive_size/responsive_size.dart';
import '../text/texts.dart';

class SortingButton extends StatelessWidget {
  const SortingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    final navigation = Provider.of<NavigationProvider>(context);
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
          onPressed: () {
            if (navigation.currentIndex == 1) {
              context.read<SortProvider>().changeSortPref();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                  text: "Sort",
                  fontFamily: "M400",
                  fontSize: ResponsiveSize.getSmallFont(context),
                  color: themeColor.secondary),
              Image.asset(
                AppIcons.sort,
                scale: 2,
                color: themeColor.secondary,
              )
            ],
          )),
    );
  }
}
