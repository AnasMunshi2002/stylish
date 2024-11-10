import 'package:flutter/material.dart';

class FlatHeels extends StatelessWidget {
  const FlatHeels({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Image.asset(
              "assets/backgrounds/mac.png",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
