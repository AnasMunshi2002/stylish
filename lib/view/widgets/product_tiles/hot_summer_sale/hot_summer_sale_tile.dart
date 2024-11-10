import 'package:flutter/material.dart';

class HotSummerSaleTile extends StatelessWidget {
  const HotSummerSaleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/backgrounds/Mask Group.png",
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
