import 'package:flutter/material.dart';

import '../../assets/icons/app_icons.dart';
import '../../assets/images/app_images.dart';
import '../../responsive_size/responsive_size.dart';
import '../../text/texts.dart';

class AllColorProductTile extends StatelessWidget {
  const AllColorProductTile({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Center(
        child: Stack(alignment: Alignment.centerLeft, children: [
      Image.asset(
        AppImages.allColours,
      ),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                    text: "50-40% OFF",
                    fontSize:
                        (MediaQuery.of(context).size.width * 0.05).toInt(),
                    fontFamily: "M700",
                    color: Colors.white),
                TextWidget(
                    text: "Now in (product)",
                    fontSize:
                        (MediaQuery.of(context).size.width * 0.036).toInt(),
                    fontFamily: "M400",
                    color: Colors.white),
                TextWidget(
                    text: "All colours",
                    fontSize:
                        (MediaQuery.of(context).size.width * 0.036).toInt(),
                    fontFamily: "M400",
                    color: Colors.white),
                const SizedBox(height: 7),
                SizedBox(
                    width: width >= 576 ? width * 0.32 : width * 0.38,
                    height: ResponsiveSize.getLargeFont(context).toDouble(),
                    child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            overlayColor:
                                const WidgetStatePropertyAll(Colors.white60),
                            side: const WidgetStatePropertyAll(
                                BorderSide(width: 1, color: Colors.white)),
                            shape: WidgetStatePropertyAll(
                                ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)))),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          TextWidget(
                              text: "Shop Now",
                              fontSize: (width * 0.036).toInt(),
                              fontFamily: "M600",
                              color: Colors.white),
                          const SizedBox(width: 4),
                          Image.asset(AppIcons.rightArrow,
                              scale: ResponsiveSize.getScale(context))
                        ])))
              ]))
    ]));
  }
}
