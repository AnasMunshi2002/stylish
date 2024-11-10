import 'package:flutter/material.dart';

import '../../../view_models/theme_provider/colors/common.dart';
import '../../screens/view_screens/view_image.dart';
import '../assets/icons/app_icons.dart';
import '../assets/images/app_images.dart';

class CircleProfile extends StatelessWidget {
  final void Function() event;

  const CircleProfile({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ViewImage(image: AppImages.profile)));
        },
        child: Stack(alignment: Alignment.bottomRight, children: [
          const Hero(
            tag: "imageHero",
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppImages.profile),
            ),
          ),
          SizedBox(
              height: 32,
              width: 32,
              child: FilledButton(
                  style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                      shape: WidgetStatePropertyAll(CircleBorder(
                          side: BorderSide(
                              width: 3, color: CommonColors.whiteC))),
                      backgroundColor:
                          WidgetStatePropertyAll(CommonColors.appBarTitle)),
                  onPressed: () {},
                  child: Image.asset(AppIcons.editPen, scale: 2)))
        ]));
  }
}
