import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/product_provider/cloth_size_provider.dart';
import '../../../view_models/product_provider/product_provider.dart';
import '../../../view_models/theme_provider/colors/common.dart';

class SizeButton extends StatelessWidget {
  final int? size;
  final String? clothSize;

  const SizeButton({this.clothSize, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: width >= 576 ? width * 0.05 : width * 0.07,
        width: width >= 576 ? width * 0.1 : width * 0.15,
        child: OutlinedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll((size == null
                        ? (context.watch<ClothSizeProvider>().size == clothSize)
                        : (context.watch<ProductProvider>().size == size))
                    ? CommonColors.commonPink
                    : CommonColors.whiteC),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
                side: const WidgetStatePropertyAll(
                    BorderSide(color: CommonColors.commonPink, width: 1.5))),
            onPressed: () {
              if (size == null) {
                context.read<ClothSizeProvider>().selectSize(clothSize!, 200);
              } else {
                context.read<ProductProvider>().selectSize(size!);
              }
            },
            child: Text(size == null ? clothSize.toString() : "$size UK",
                style: TextStyle(
                    fontFamily: "M600",
                    fontSize: MediaQuery.of(context).size.width >= 576
                        ? MediaQuery.of(context).size.width * 0.03
                        : MediaQuery.of(context).size.width * 0.04,
                    color: (size == null
                            ? (context.watch<ClothSizeProvider>().size ==
                                clothSize)
                            : (context.watch<ProductProvider>().size == size))
                        ? CommonColors.whiteC
                        : CommonColors.commonPink))));
  }
}
