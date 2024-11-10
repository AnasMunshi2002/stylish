import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/screen_models/shopping_list_product.dart';
import '../../../../services/api/fetch_categories/fetch_categories.dart';
import '../../../../services/static_data/static_data.dart';
import '../../../../view_models/page_view_provider/page_view_provider.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/assets/icons/app_icons.dart';
import '../../../widgets/assets/images/app_images.dart';
import '../../../widgets/filter_button/filter_button.dart';
import '../../../widgets/list_horizontal/list_horizontal.dart';
import '../../../widgets/page_view_home/page_view_home.dart';
import '../../../widgets/product_tiles/all_color_product/all_color_product_tile.dart';
import '../../../widgets/product_tiles/flat_heels_tile/flat_heels.dart';
import '../../../widgets/product_tiles/hot_summer_sale/hot_summer_sale_tile.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/searchbar/search_bar.dart';
import '../../../widgets/sort_button/sort_button.dart';
import '../../../widgets/text/texts.dart';
import '../../../widgets/trending and deals button/button.dart';
import '../view_category_products/view_category_products.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final _searchController = TextEditingController();
  late PageController _pageController;

  late final ScrollController _scrollController1;
  late final ScrollController _scrollController2;
  final FetchCategories fetchCategories = FetchCategories();

  @override
  void initState() {
    _pageController = PageController();
    _scrollController1 =
        ScrollController(keepScrollOffset: true, initialScrollOffset: 0);
    _scrollController2 =
        ScrollController(keepScrollOffset: true, initialScrollOffset: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    /*final pageView = Provider.of<PageViewProvider>(context);*/
    return FutureBuilder(
        future: fetchCategories.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: themeColor.secondary,
            ));
          } else {
            List categories = snapshot.data!;
            final List categoriesImages = [
              [
                "assets/logo/Ellipse 4.png",
                categories.elementAt(categories.indexOf("jewelery"))
              ],
              [
                "assets/logo/unsplash__3Q3tsJ01nc.png",
                categories.elementAt(categories.indexOf("women's clothing"))
              ],
              [
                "assets/logo/unsplash_GCDjllzoKLo.png",
                categories.elementAt(categories.indexOf("electronics"))
              ],
              [
                "assets/logo/unsplash_xPJYL0l5Ii8.png",
                categories.elementAt(categories.indexOf("men's clothing"))
              ],
            ];
            return SizedBox(
                height: double.maxFinite,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: SearchBox(controller: _searchController)),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                                color: themeColor.secondary,
                                text: 'All Featured',
                                fontFamily: "M600",
                                fontSize:
                                    ResponsiveSize.getMediumLargeFont(context)),
                            Row(children: [
                              const SortingButton(),
                              SizedBox(
                                  width: ResponsiveSize.getNavBarFont(context)
                                      .toDouble()),
                              const FilterButton()
                            ])
                          ])),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: ResponsiveSize.categoriesHeight(context),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoriesImages.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewCategoryProducts(
                                                  category:
                                                      categoriesImages[index]
                                                          [1],
                                                )));
                                  },
                                  child: Column(children: [
                                    CircleAvatar(
                                        radius:
                                            (MediaQuery.of(context).size.width >
                                                    576
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.055
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.073),
                                        foregroundImage: AssetImage(
                                            categoriesImages[index][0])),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    TextWidget(
                                        text: categoriesImages[index][1],
                                        fontFamily: "M400",
                                        fontSize: (ResponsiveSize.getSmallFont(
                                                    context) *
                                                0.9)
                                            .toInt(),
                                        color: themeColor.secondary)
                                  ]),
                                ));
                          })),
                  SizedBox(height: (MediaQuery.of(context).size.width * 0.03)),
                  const PageSlider(),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                  DealsTrendingButton(
                      event: () {},
                      title: "Deal of the Day",
                      icon: Image.asset(
                        AppIcons.clock,
                        scale: 2,
                      ),
                      bgColor: CommonColors.appBarTitle,
                      subtitle: "22h 55m 20s remaining "),
                  Consumer<PageViewProvider>(
                      builder: (context, consumer, child) {
                    return Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                      height: MediaQuery.of(context).size.height * 0.34,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          ListView.builder(
                              itemCount: StaticData.list.length,
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController1,
                              itemBuilder: (context, index) {
                                ShoppingListProduct prod =
                                    StaticData.list[index];
                                return ListHorizontal(prod: prod);
                              }),
                          Positioned(
                              left: 0,
                              child: Visibility(
                                  visible: consumer.offset1 > 10 ||
                                      (_scrollController1.hasClients
                                          ? _scrollController1.offset > 20
                                          : false),
                                  child: IconButton.filled(
                                      style: const ButtonStyle(
                                          padding: WidgetStatePropertyAll(
                                              EdgeInsets.all(0))),
                                      onPressed: () {
                                        _scrollLeft(1, context);
                                      },
                                      icon: Container(
                                          transformAlignment: Alignment.center,
                                          transform: Matrix4.rotationY(3),
                                          child: Image.asset(
                                              AppIcons.cupertinoRightArrow,
                                              scale: ResponsiveSize.getScale(
                                                  context)))))),
                          IconButton.filled(
                              style: const ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.all(0))),
                              onPressed: () {
                                _scrollRight(1, context);
                              },
                              icon: Image.asset(
                                AppIcons.cupertinoRightArrow,
                                scale: ResponsiveSize.getScale(context),
                              )),
                        ],
                      ),
                    );
                  }),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: themeColor.primaryFixed,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 0.1,
                              spreadRadius: 0.5,
                              color: themeColor.onPrimaryContainer),
                          BoxShadow(
                              blurRadius: 0.1,
                              spreadRadius: 0.5,
                              color: themeColor.tertiary)
                        ]),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    height: MediaQuery.of(context).size.height > 1000
                        ? MediaQuery.of(context).size.height * 0.11
                        : MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/Rectangle 56.png",
                          scale: MediaQuery.of(context).size.height > 1000
                              ? 1.2
                              : 2,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Special Offers",
                                  style: TextStyle(
                                      fontFamily: "M500",
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width >=
                                              576
                                          ? MediaQuery.of(context).size.height *
                                              0.025
                                          : MediaQuery.of(context).size.height *
                                              0.022,
                                      color: themeColor.secondary),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                    child: Image.asset(
                                      "assets/icons/emoji1.png",
                                      fit: BoxFit.cover,
                                    ))
                              ],
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width >= 576
                                    ? (MediaQuery.of(context).size.width * 0.6)
                                    : (MediaQuery.of(context).size.width * 0.5),
                                child: Text(
                                  textAlign: TextAlign.left,
                                  "We make sure you get the offer you need at best prices",
                                  style: TextStyle(
                                    color: themeColor.secondary,
                                    fontFamily: "M400",
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .width >=
                                            576
                                        ? (MediaQuery.of(context).size.width *
                                            0.025)
                                        : (MediaQuery.of(context).size.width *
                                            0.03),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Consumer<PageViewProvider>(
                      builder: (context, consumer, child) {
                    return Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.27,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PageView(
                        onPageChanged: (index) {
                          consumer.changePage(index);
                        },
                        controller: _pageController,
                        children: const [
                          FlatHeels(),
                          HotSummerSaleTile(),
                          AllColorProductTile(),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 13,
                  ),
                  DealsTrendingButton(
                      event: () {},
                      title: "Trending Products",
                      icon:
                          Image.asset("assets/icons/Component 1-calender.png"),
                      bgColor: const Color(0xffFD6E87),
                      subtitle: "Last Date 29/02/22"),
                  const SizedBox(height: 12),
                  Consumer<PageViewProvider>(
                      builder: (context, consumer, child) {
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        height: MediaQuery.of(context).size.height * 0.34,
                        child:
                            Stack(alignment: Alignment.centerRight, children: [
                          ListView.builder(
                              itemCount: StaticData.list.length,
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController2,
                              itemBuilder: (context, index) {
                                ShoppingListProduct prod =
                                    StaticData.list[index];
                                return ListHorizontal(prod: prod);
                              }),
                          Positioned(
                              left: 0,
                              child: Visibility(
                                  visible: consumer.offset2 > 10 ||
                                      (_scrollController2.hasClients
                                          ? _scrollController2.offset > 20
                                          : false),
                                  child: IconButton.filled(
                                      style: const ButtonStyle(
                                          padding: WidgetStatePropertyAll(
                                              EdgeInsets.all(0))),
                                      onPressed: () {
                                        _scrollLeft(2, context);
                                      },
                                      icon: Container(
                                          transformAlignment: Alignment.center,
                                          transform: Matrix4.rotationY(3),
                                          child: Image.asset(
                                              AppIcons.cupertinoRightArrow,
                                              scale: ResponsiveSize.getScale(
                                                  context)))))),
                          IconButton.filled(
                              style: const ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.all(0))),
                              onPressed: () {
                                _scrollRight(2, context);
                              },
                              icon: Image.asset(AppIcons.cupertinoRightArrow,
                                  scale: ResponsiveSize.getScale(context)))
                        ]));
                  }),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              child: Image.asset(AppImages.hotSummerSale,
                                  fit: BoxFit.fill))
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text: "New Arrivals ",
                                      fontFamily: "M500",
                                      fontSize:
                                          ResponsiveSize.getMediumFont(context),
                                      color: themeColor.secondary),
                                  TextWidget(
                                    color: themeColor.secondary,
                                    text: "Summer' 25 Collection",
                                    fontFamily: "M400",
                                    fontSize:
                                        ResponsiveSize.getMediumFont(context),
                                  )
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.08,
                                  child: FilledButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                  CommonColors.buttonColor),
                                          shape: WidgetStatePropertyAll(
                                              ContinuousRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4))),
                                          padding: const WidgetStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 6))),
                                      onPressed: () {},
                                      child: Row(children: [
                                        TextWidget(
                                            fontFamily: "M500",
                                            color: CommonColors.whiteC,
                                            text: "View all",
                                            fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03)
                                                .toInt()),
                                        const SizedBox(width: 6),
                                        Image.asset(
                                            "assets/icons/Component 3.png")
                                      ])))
                            ])
                      ])),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 16, top: 20, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sponsored",
                                style: TextStyle(
                                    fontFamily: "M500",
                                    fontSize:
                                        (MediaQuery.of(context).size.width *
                                            0.04))),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Row(children: [
                                  Expanded(
                                      child: Image.asset(AppImages.leatherShoes,
                                          fit: BoxFit.fill))
                                ])),
                            ListTile(
                                onTap: () {},
                                title: Text("up to 50% Off",
                                    style: TextStyle(
                                        fontFamily: "M700",
                                        fontSize:
                                            (MediaQuery.of(context).size.width *
                                                0.03))),
                                trailing: Image.asset(AppIcons.cupertinoRight,
                                    color: themeColor.secondary,
                                    scale: ResponsiveSize.getScale(context)))
                          ]))
                ])));
          }
        });
  }

  void _scrollRight(int n, BuildContext context) {
    if (n == 1) {
      _scrollController1.animateTo(_scrollController1.offset + 200,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      context
          .read<PageViewProvider>()
          .changeOffset(_scrollController1.offset, 1);
    } else {
      if (_scrollController2.hasClients) {
        _scrollController2.animateTo(_scrollController2.offset + 200,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        context
            .read<PageViewProvider>()
            .changeOffset(_scrollController2.offset, 2);
      }
    }
  }

  void _scrollLeft(int n, BuildContext context) {
    if (n == 1) {
      if (_scrollController1.hasClients) {
        _scrollController1.animateTo(_scrollController1.offset - 200,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        context
            .read<PageViewProvider>()
            .changeOffset(_scrollController1.offset, 1);
      }
    } else {
      if (_scrollController2.hasClients) {
        _scrollController2.animateTo(_scrollController2.offset - 200,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        context
            .read<PageViewProvider>()
            .changeOffset(_scrollController2.offset, 2);
      }
    }
  }
}
