import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/screen_models/shopping_list_product.dart';
import '../../../view_models/theme_provider/colors/common.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../responsive_size/responsive_size.dart';
import '../text/texts.dart';

class ListHorizontal extends StatelessWidget {
  final ShoppingListProduct prod;

  const ListHorizontal({required this.prod, super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return Row(children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: themeColor.primaryFixed),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: (ResponsiveSize.getMediumFont(context)).toDouble() * 11,
                height: (ResponsiveSize.getSmallFont(context)).toDouble() * 10,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: Image.asset(prod.image, fit: BoxFit.fitWidth)),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          text: prod.title,
                          fontFamily: "M500",
                          fontSize: ResponsiveSize.getSmallFont(context),
                          color: themeColor.secondary),
                      SizedBox(
                          width: ResponsiveSize.getMediumFont(context) * 10,
                          child: TextWidget(
                            text: prod.desc,
                            fontFamily: "M400",
                            fontSize:
                                (ResponsiveSize.getNavBarFont(context) * 0.9)
                                    .toInt(),
                            color: themeColor.secondary,
                          )),
                      TextWidget(
                        text: prod.price.toString(),
                        fontFamily: "M500",
                        fontSize: ResponsiveSize.getSmallFont(context),
                        color: themeColor.secondary,
                      ),
                      Row(children: [
                        Text(
                          prod.originalPrice.toString(),
                          style: TextStyle(
                              fontFamily: "M400",
                              fontSize: ResponsiveSize.getSmallFont(context)
                                  .toDouble(),
                              color: themeColor.secondary,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: themeColor.secondary),
                        ),
                        const SizedBox(width: 16),
                        TextWidget(
                            text: "${prod.discount}% off",
                            fontFamily: "M400",
                            fontSize: ResponsiveSize.getSmallFont(context),
                            color: CommonColors.navBarActive)
                      ])
                    ]))
          ])),
      const SizedBox(width: 20)
    ]);
  }
}
