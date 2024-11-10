import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/product_provider/add_product_provider/add_provider.dart';
import '../../../view_models/theme_provider/colors/common.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../responsive_size/responsive_size.dart';
import '../text/texts.dart';

class CategoryButtons extends StatelessWidget {
  final String image;
  final String categoryString;
  final String label;

  const CategoryButtons(
      {required this.categoryString,
      required this.label,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    final fieldProvider = context.watch<AddProductProvider>();
    Color activeColor = fieldProvider.category == categoryString
        ? CommonColors.buttonColor
        : themeColor.secondary;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: activeColor)),
      alignment: Alignment.center,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              side: BorderSide(color: activeColor, width: 1))),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
        ),
        onPressed: () {
          if (fieldProvider.category.isEmpty) {
            fieldProvider.changeCategory(categoryString);
            fieldProvider.increaseField();
          } else {
            fieldProvider.changeCategory(categoryString);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minHeight: 50, maxHeight: 100, minWidth: double.maxFinite),
              child: SizedBox(
                width: double.maxFinite,
                height: ResponsiveSize.buttonHeight(context),
                child: Image.asset(
                  image,
                  color: activeColor,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextWidget(
              text: label,
              color: activeColor,
              fontFamily: "M500",
              fontSize: (ResponsiveSize.getSmallFont(context) * 0.7).toInt(),
            ),
          ],
        ),
      ),
    );
  }
}
