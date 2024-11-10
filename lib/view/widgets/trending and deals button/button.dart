import 'package:flutter/material.dart';

import '../../../view_models/theme_provider/colors/common.dart';
import '../text/texts.dart';

class DealsTrendingButton extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String subtitle;
  final Image icon;
  final Function() event;

  const DealsTrendingButton(
      {required this.title,
      required this.event,
      required this.icon,
      required this.bgColor,
      required this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  text: title,
                  fontFamily: "M500",
                  fontSize: (MediaQuery.of(context).size.width * 0.04).toInt(),
                  color: Colors.white),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 4,
                  ),
                  TextWidget(
                      text: subtitle,
                      fontFamily: "M400",
                      fontSize:
                          (MediaQuery.of(context).size.width * 0.033).toInt(),
                      color: Colors.white),
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.08,
            child: OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
                  overlayColor: const WidgetStatePropertyAll(Colors.white60),
                  side: WidgetStatePropertyAll(
                    BorderSide(
                        width: MediaQuery.of(context).size.width > 576 ? 2 : 1,
                        color: CommonColors.whiteC),
                  ),
                  shape: WidgetStatePropertyAll(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("View All",
                        style: TextStyle(
                            fontSize:
                                (MediaQuery.of(context).size.width * 0.03),
                            fontFamily: "M600",
                            color: CommonColors.whiteC)),
                    const SizedBox(
                      width: 4,
                    ),
                    Image.asset(
                      "assets/icons/Component 3.png",
                      scale: MediaQuery.of(context).size.width >= 576 ? 1.2 : 2,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
