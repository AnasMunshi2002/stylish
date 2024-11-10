import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/page_view_provider/page_view_provider.dart';
import '../../../view_models/theme_provider/colors/common.dart';
import '../product_tiles/all_color_product/all_color_product_tile.dart';
import '../product_tiles/flat_heels_tile/flat_heels.dart';
import '../product_tiles/hot_summer_sale/hot_summer_sale_tile.dart';
import '../responsive_size/responsive_size.dart';

class PageSlider extends StatefulWidget {
  const PageSlider({super.key});

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> with TickerProviderStateMixin {
  late final PageController pageController;
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
/*
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
*/
    return Consumer<PageViewProvider>(builder: (context, consumer, child) {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: ResponsiveSize.pageViewHeight(context),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PageView(
              onPageChanged: (index) {
                consumer.changePage(index);
              },
              controller: pageController,
              children: const [
                AllColorProductTile(),
                FlatHeels(),
                Row(
                  children: [
                    Expanded(child: HotSummerSaleTile()),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height >= 700
                ? (MediaQuery.of(context).size.height >= 1000
                    ? MediaQuery.of(context).size.width * 0.03
                    : MediaQuery.of(context).size.width * 0.002)
                : (MediaQuery.of(context).size.width * 0.03)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size:
                            MediaQuery.of(context).size.width >= 576 ? 15 : 10,
                        color: consumer.pageNo == 0
                            ? const Color(0xffFFA3B3)
                            : CommonColors.greyC,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.circle,
                        size:
                            MediaQuery.of(context).size.width >= 576 ? 15 : 10,
                        color: consumer.pageNo == 1
                            ? const Color(0xffFFA3B3)
                            : CommonColors.greyC,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.circle,
                        size:
                            MediaQuery.of(context).size.width >= 576 ? 15 : 10,
                        color: consumer.pageNo == 2
                            ? const Color(0xffFFA3B3)
                            : CommonColors.greyC,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      );
    });
  }
}
