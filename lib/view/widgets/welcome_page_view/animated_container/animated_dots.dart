import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/page_view_provider/page_view_provider.dart';
import '../../../../view_models/theme_provider/theme.dart';

class AnimatedDots extends StatelessWidget {
  final int currentPage;

  const AnimatedDots({required this.currentPage, super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: context.read<PageViewProvider>().pageNo == currentPage ? 40 : 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.watch<PageViewProvider>().pageNo == currentPage
              ? themeColor.secondary
              : themeColor.tertiary),
    );
  }
}
