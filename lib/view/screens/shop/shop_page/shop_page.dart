import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

import '../../../../models/screen_models/trending_products.dart';
import '../../../../services/static_data/static_data.dart';
import '../../../../view_models/page_view_provider/page_view_provider.dart';
import '../../../../view_models/product_provider/product_provider.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/assets/icons/app_icons.dart';
import '../../../widgets/assets/images/app_images.dart';
import '../../../widgets/filter_button/filter_button.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/size_button/size_button.dart';
import '../../../widgets/sort_button/sort_button.dart';
import '../../../widgets/text/texts.dart';
import '../../checkout/checkout.dart';
import '../../view_screens/view_image.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    _pageController = PageController();
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    return ListView(children: [
      Container(
          margin: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          height: ResponsiveSize.getShopPagePhotoHeight(context),
          width: width,
          child: PageView(
              onPageChanged: (index) {
                context.read<PageViewProvider>().changePage(index);
              },
              controller: _pageController,
              children: List.generate(
                  5,
                  (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewImage(
                                    image: AppImages.jordanShoes)));
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Hero(
                              tag: "imageHero",
                              child: Image.asset(
                                AppImages.jordanShoes,
                                fit: BoxFit.fill,
                              ))))))),
      const SizedBox(height: 6),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        PageIndicator(
            currentPageIndex: context.watch<PageViewProvider>().pageNo,
            tabController: _tabController,
            onUpdateCurrentPage: _updateCurrentPage),
      ]),
      const SizedBox(height: 14),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextWidget(
              text: "Size: ${context.watch<ProductProvider>().size} UK",
              color: themeColor.secondary,
              fontFamily: "M600",
              fontSize: ResponsiveSize.getMediumFont(context))),
      const SizedBox(height: 10),
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(children: [
            SizeButton(size: 6),
            SizedBox(width: 8),
            SizeButton(size: 7),
            SizedBox(width: 8),
            SizeButton(size: 8),
            SizedBox(width: 8),
            SizeButton(size: 9),
            SizedBox(width: 8),
            SizeButton(size: 10)
          ])),
      Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 5),
          child: TextWidget(
              text: "Nike Sneakers",
              color: themeColor.secondary,
              fontFamily: "M600",
              fontSize: ResponsiveSize.getMediumLargeFont(context))),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextWidget(
              text: "Vision Alta Men’s Shoes Size (All Colours)",
              color: themeColor.secondary,
              fontFamily: "M400",
              fontSize: ResponsiveSize.getSmallFont(context))),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Row(children: [
            StarRating(
                color: CommonColors.ratingStar,
                size: MediaQuery.of(context).size.width >= 576 ? 24 : 18,
                rating: 4.5),
            const SizedBox(width: 10),
            TextWidget(
                text: "56,890",
                fontSize: ResponsiveSize.getSmallFont(context),
                fontFamily: "M500",
                color: const Color(0xffA4A9B3))
          ])),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            Text("₹2999",
                style: TextStyle(
                    fontFamily: "M400",
                    fontSize: ResponsiveSize.getSmallFont(context).toDouble(),
                    color: themeColor.secondary,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: themeColor.secondary)),
            const SizedBox(width: 8),
            TextWidget(
                color: themeColor.secondary,
                text: context.watch<ProductProvider>().price.toString(),
                fontFamily: "M500",
                fontSize: ResponsiveSize.getSmallFont(context)),
            const SizedBox(width: 8),
            TextWidget(
                text: "60% off",
                fontFamily: "M600",
                fontSize: ResponsiveSize.getSmallFont(context),
                color: CommonColors.commonPink)
          ])),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
          child: TextWidget(
              text: "Product Details",
              color: themeColor.secondary,
              fontFamily: "M500",
              fontSize: ResponsiveSize.getMediumFont(context))),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: themeColor.secondary,
                      fontFamily: "M400",
                      fontSize:
                          ResponsiveSize.getSmallFont(context).toDouble()),
                  text:
                      "Perhaps the most iconic sneaker of all-time, this original \"Chicago\"? colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. This 2015 release saw the ...",
                  children: const [
                TextSpan(
                    text: "More",
                    style: TextStyle(
                        fontFamily: "M500", color: CommonColors.commonPink))
              ]))),
      const SizedBox(height: 12),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
                child: OutlinedButton(
                    style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 6)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                        side: WidgetStatePropertyAll(BorderSide(
                            color: themeColor.secondary, width: 1.5))),
                    onPressed: () {},
                    child: Row(children: [
                      Image.asset(AppIcons.location,
                          color: themeColor.secondary,
                          scale: ResponsiveSize.getScale(context)),
                      const SizedBox(width: 4),
                      TextWidget(
                        text: "Nearest Store",
                        color: themeColor.secondary,
                        fontSize: ResponsiveSize.getNavBarFont(context),
                      )
                    ]))),
            const SizedBox(width: 8),
            SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
                child: OutlinedButton(
                    style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 6)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                        side: WidgetStatePropertyAll(BorderSide(
                            color: themeColor.secondary, width: 1.5))),
                    onPressed: () {},
                    child: Row(children: [
                      Image.asset(AppIcons.lock,
                          color: themeColor.secondary,
                          scale: ResponsiveSize.getScale(context)),
                      const SizedBox(width: 4),
                      TextWidget(
                          text: "VIP",
                          color: themeColor.secondary,
                          fontSize: ResponsiveSize.getNavBarFont(context))
                    ]))),
            const SizedBox(width: 8),
            SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
                child: OutlinedButton(
                    style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 6)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                        side: WidgetStatePropertyAll(BorderSide(
                            color: themeColor.secondary, width: 1.5))),
                    onPressed: () {},
                    child: Row(children: [
                      Image.asset(AppIcons.returnPolicy,
                          color: themeColor.secondary,
                          scale: width >= 576 ? 0.5 : 1),
                      const SizedBox(width: 4),
                      TextWidget(
                          text: "Return policy",
                          color: themeColor.secondary,
                          fontSize: ResponsiveSize.getNavBarFont(context))
                    ])))
          ])),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            shopButton(
                CommonColors.gradientLightBlue,
                CommonColors.gradientDarkBlue,
                Image.asset(AppIcons.cart,
                    scale: ResponsiveSize.getScale(context),
                    color: CommonColors.whiteC),
                "Go to cart"),
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),
            shopButton(
                CommonColors.gradientLightGreen,
                CommonColors.gradientDarkGreen,
                Image.asset(AppIcons.buyNow,
                    scale: MediaQuery.of(context).size.width >= 576 ? 0.4 : 1,
                    color: CommonColors.whiteC),
                "Buy Now")
          ])),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              color: CommonColors.lightPink,
              borderRadius: BorderRadius.circular(5)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    text: "Delivery",
                    color: CommonColors.blackC,
                    fontFamily: "M600",
                    fontSize: ResponsiveSize.getMediumFont(context)),
                TextWidget(
                    text: "within 1 Hour",
                    color: CommonColors.blackC,
                    fontFamily: "M600",
                    fontSize: ResponsiveSize.getTitleFont(context))
              ])),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(children: [
            Expanded(
                child: simpleButton(
                    Image.asset(
                      AppIcons.view,
                      color: CommonColors.blackC,
                      scale: ResponsiveSize.getScale(context),
                    ),
                    "View Similar")),
            SizedBox(width: MediaQuery.of(context).size.width >= 576 ? 10 : 5),
            Expanded(
                child: simpleButton(
                    Image.asset(
                      color: CommonColors.blackC,
                      AppIcons.compare,
                      scale: ResponsiveSize.getScale(context),
                    ),
                    "Add to compare"))
          ])),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
          child: TextWidget(
              text: "Similar to",
              fontFamily: "M600",
              fontSize: 20,
              color: themeColor.secondary)),
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("282+ items",
                style: TextStyle(fontFamily: "M600", fontSize: 18)),
            Row(children: [
              SizedBox(
                height: 24,
                width: 61,
                child: SortingButton(),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(height: 24, width: 61, child: FilterButton()),
            ])
          ])),
      const SizedBox(height: 10),
      SizedBox(
          height: 250,
          child: ListView.builder(
              padding: const EdgeInsets.only(left: 16),
              itemCount: StaticData.similarProducts.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Products prod = StaticData.similarProducts[index];
                return Row(children: [
                  Container(
                      color: themeColor.primary,
                      child: MaterialButton(
                          onPressed: () {},
                          padding: const EdgeInsets.all(0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 170,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Image.asset(prod.image)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(prod.title,
                                    style: const TextStyle(
                                        fontFamily: "M600", fontSize: 16)),
                                SizedBox(
                                    width: 134,
                                    child: Text(prod.desc,
                                        style: const TextStyle(
                                            fontFamily: "M500", fontSize: 10))),
                                Text(prod.price,
                                    style: const TextStyle(
                                        fontFamily: "M500", fontSize: 12)),
                                Row(children: [
                                  StarRating(
                                    rating: double.parse(prod.rating),
                                    color: CommonColors.ratingStar,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(prod.noReview,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontFamily: "M500",
                                          color: CommonColors.greyC))
                                ])
                              ]))),
                  const SizedBox(width: 16)
                ]);
              }))
    ]);
  }

  simpleButton(Image icon, String text) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(themeColor.onPrimaryContainer),
            side: WidgetStatePropertyAll(
                BorderSide(width: 0.5, color: themeColor.secondary)),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 7)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        onPressed: () {},
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon,
          const SizedBox(width: 14),
          TextWidget(
              color: CommonColors.blackC,
              text: text,
              fontFamily: "M500",
              fontSize: ResponsiveSize.getNavBarFont(context))
        ]));
  }

  shopButton(Color color1, Color color2, Image icon, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Checkout()));
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: ResponsiveSize.getLargeFont(context).toDouble(),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width >= 576
                    ? MediaQuery.of(context).size.width * 0.1
                    : MediaQuery.of(context).size.width * 0.13,
                right: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    topLeft: Radius.circular(100),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [color1, color2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: FilledButton(
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          topLeft: Radius.circular(100),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20))))),
              onPressed: () {
                if (text == "Buy Now") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Checkout()));
                } else if (text == "Go to cart") {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AllCart()));*/
                }
              },
              child: TextWidget(
                text: text,
                fontFamily: "M600",
                color: CommonColors.whiteC,
                fontSize: ResponsiveSize.getMediumFont(context),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                gradient: RadialGradient(
                  colors: [color1, color2],
                  radius: 1,
                )),
            child: SizedBox(
              height: MediaQuery.of(context).size.width >= 576
                  ? MediaQuery.of(context).size.width * 0.07
                  : MediaQuery.of(context).size.width * 0.11,
              width: MediaQuery.of(context).size.width >= 576
                  ? MediaQuery.of(context).size.width * 0.07
                  : MediaQuery.of(context).size.width * 0.11,
              child: IconButton(
                  style: const ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100))))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Checkout()));
                  },
                  icon: icon),
            ),
          )
        ],
      ),
    );
  }

  void _updateCurrentPage(int page) {
    _tabController.index = page;
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}

class PageIndicator extends StatelessWidget {
  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPage;

  const PageIndicator(
      {super.key,
      required this.currentPageIndex,
      required this.tabController,
      required this.onUpdateCurrentPage});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Icon(Icons.circle,
            size: MediaQuery.of(context).size.width >= 576 ? 15 : 10,
            color: currentPageIndex == 0
                ? CommonColors.buttonColor
                : CommonColors.greyC),
        const SizedBox(width: 5),
        Icon(Icons.circle,
            size: MediaQuery.of(context).size.width >= 576 ? 15 : 10,
            color: currentPageIndex == 1
                ? CommonColors.buttonColor
                : CommonColors.greyC),
        const SizedBox(width: 5),
        Icon(Icons.circle,
            size: MediaQuery.of(context).size.width >= 576 ? 15 : 10,
            color: currentPageIndex == 2
                ? CommonColors.buttonColor
                : CommonColors.greyC),
        const SizedBox(width: 5),
        Icon(Icons.circle,
            size: MediaQuery.of(context).size.width >= 576 ? 15 : 10,
            color: currentPageIndex == 3
                ? CommonColors.buttonColor
                : CommonColors.greyC),
        const SizedBox(width: 5),
        Icon(Icons.circle,
            size: MediaQuery.of(context).size.width >= 576 ? 15 : 10,
            color: currentPageIndex == 4
                ? CommonColors.buttonColor
                : CommonColors.greyC)
      ])
    ]);
  }
}
