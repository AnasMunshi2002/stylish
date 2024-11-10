import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

import '../../../models/api_models/all_products/all_products.dart';
import '../../../models/api_models/cart/cart_api_model/cart_api_model.dart';
import '../../../models/api_models/cart/cart_api_model/product.dart';
import '../../../services/api/cart/all_cart/cart_api_all.dart';
import '../../../services/api/fetch_categories/fetch_categories.dart';
import '../../../services/api/single_product/fetch_single_product.dart';
import '../../../view_models/product_provider/cloth_size_provider.dart';
import '../../../view_models/theme_provider/colors/common.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../../widgets/assets/icons/app_icons.dart';
import '../../widgets/filter_button/filter_button.dart';
import '../../widgets/responsive_size/responsive_size.dart';
import '../../widgets/size_button/size_button.dart';
import '../../widgets/sort_button/sort_button.dart';
import '../../widgets/text/texts.dart';

class ViewProduct extends StatefulWidget {
  final int id;

  const ViewProduct({required this.id, super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  late int id;
  FetchSingleProduct fetch = FetchSingleProduct();
  FetchCategories categoryAPI = FetchCategories();
  AllCartAPI cartApi = AllCartAPI();

  @override
  void initState() {
    id = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: IconButton(
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(CircleBorder()),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/icons/Vector 3.png",
                color: themeColor.secondary,
                scale: ResponsiveSize.getScale(context),
              )),
        ),
        backgroundColor: themeColor.primary,
      ),
      backgroundColor: themeColor.primary,
      body: FutureBuilder(
          future: fetch.getProduct(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: themeColor.secondary,
                ),
              );
            } else {
              AllProducts prod = snapshot.data!;

              return ListView(children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    height: ResponsiveSize.getShopPagePhotoHeight(context),
                    width: width,
                    child: Image.network(prod.image!)),
                const SizedBox(height: 6),
                Visibility(
                  visible: prod.category != "jewelery" &&
                      prod.category != "electronics",
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextWidget(
                          text:
                              "Size: ${context.watch<ClothSizeProvider>().size}",
                          color: themeColor.secondary,
                          fontFamily: "M600",
                          fontSize: ResponsiveSize.getMediumFont(context))),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: prod.category != "jewelery" &&
                      prod.category != "electronics",
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(children: [
                        SizeButton(
                          clothSize: "S",
                        ),
                        SizedBox(width: 8),
                        SizeButton(
                          clothSize: "M",
                        ),
                        SizedBox(width: 8),
                        SizeButton(
                          clothSize: "L",
                        ),
                        SizedBox(width: 8),
                        SizeButton(
                          clothSize: "XL",
                        ),
                        SizedBox(width: 8),
                        SizeButton(
                          clothSize: "XXL",
                        )
                      ])),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, top: 16, bottom: 5),
                    child: TextWidget(
                        text: prod.title!,
                        color: themeColor.secondary,
                        fontFamily: "M600",
                        fontSize: ResponsiveSize.getMediumLargeFont(context))),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 5),
                    child: Row(children: [
                      StarRating(
                          color: CommonColors.ratingStar,
                          size: MediaQuery.of(context).size.width >= 576
                              ? 24
                              : 18,
                          rating: prod.rating!.rate!),
                      const SizedBox(width: 10),
                      TextWidget(
                          text: prod.rating!.count!.toString(),
                          fontSize: ResponsiveSize.getSmallFont(context),
                          fontFamily: "M500",
                          color: const Color(0xffA4A9B3))
                    ])),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(children: [
                      /*Text("₹2999",
                          style: TextStyle(
                              fontFamily: "M400",
                              fontSize: ResponsiveSize.getSmallFont(context)
                                  .toDouble(),
                              color: themeColor.secondary,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: themeColor.secondary)),
                      const SizedBox(width: 8),*/
                      TextWidget(
                          color: themeColor.secondary,
                          text: "\$${prod.price.toString()}",
                          fontFamily: "M500",
                          fontSize: ResponsiveSize.getMediumFont(context)),
                      const SizedBox(width: 8),
                    ])),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 7),
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
                                fontSize: ResponsiveSize.getSmallFont(context)
                                    .toDouble()),
                            text: prod.description,
                            children: const [
                          TextSpan(
                              text: "More",
                              style: TextStyle(
                                  fontFamily: "M500",
                                  color: CommonColors.commonPink))
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
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  side: WidgetStatePropertyAll(BorderSide(
                                      color: themeColor.secondary,
                                      width: 1.5))),
                              onPressed: () {},
                              child: Row(children: [
                                Image.asset(AppIcons.location,
                                    color: themeColor.secondary,
                                    scale: ResponsiveSize.getScale(context)),
                                const SizedBox(width: 4),
                                TextWidget(
                                  text: "Nearest Store",
                                  color: themeColor.secondary,
                                  fontSize:
                                      ResponsiveSize.getNavBarFont(context),
                                )
                              ]))),
                      const SizedBox(width: 8),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.06,
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(horizontal: 6)),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  side: WidgetStatePropertyAll(BorderSide(
                                      color: themeColor.secondary,
                                      width: 1.5))),
                              onPressed: () {},
                              child: Row(children: [
                                Image.asset(AppIcons.lock,
                                    color: themeColor.secondary,
                                    scale: ResponsiveSize.getScale(context)),
                                const SizedBox(width: 4),
                                TextWidget(
                                    text: "VIP",
                                    color: themeColor.secondary,
                                    fontSize:
                                        ResponsiveSize.getNavBarFont(context))
                              ]))),
                      const SizedBox(width: 8),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.06,
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(horizontal: 6)),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  side: WidgetStatePropertyAll(BorderSide(
                                      color: themeColor.secondary,
                                      width: 1.5))),
                              onPressed: () {},
                              child: Row(children: [
                                Image.asset(AppIcons.returnPolicy,
                                    color: themeColor.secondary,
                                    scale: width >= 576 ? 0.5 : 1),
                                const SizedBox(width: 4),
                                TextWidget(
                                    text: "Return policy",
                                    color: themeColor.secondary,
                                    fontSize:
                                        ResponsiveSize.getNavBarFont(context))
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
                          "Add to cart",
                          prod),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      shopButton(
                          CommonColors.gradientLightGreen,
                          CommonColors.gradientDarkGreen,
                          Image.asset(AppIcons.buyNow,
                              scale: MediaQuery.of(context).size.width >= 576
                                  ? 0.4
                                  : 1,
                              color: CommonColors.whiteC),
                          "Buy Now",
                          prod)
                    ])),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23, vertical: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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
                /*Padding(
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width >= 576
                              ? 10
                              : 5),
                      Expanded(
                          child: simpleButton(
                              Image.asset(
                                color: CommonColors.blackC,
                                AppIcons.compare,
                                scale: ResponsiveSize.getScale(context),
                              ),
                              "Add to compare"))
                    ])),*/
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 6),
                    child: TextWidget(
                        text: "Similar to",
                        fontFamily: "M600",
                        fontSize: 20,
                        color: themeColor.secondary)),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("282+ items",
                              style:
                                  TextStyle(fontFamily: "M600", fontSize: 18)),
                          Row(children: [
                            SizedBox(
                              height: 24,
                              width: 61,
                              child: SortingButton(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                height: 24, width: 61, child: FilterButton()),
                          ])
                        ])),
                const SizedBox(height: 10),
                SizedBox(
                    height: 250,
                    child: FutureBuilder(
                        future: categoryAPI
                            .getCategoryProducts(prod.category.toString()),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: themeColor.secondary,
                              ),
                            );
                          }
                          List<AllProducts> catProducts = snap.data!;
                          return ListView.builder(
                              padding: const EdgeInsets.only(left: 16),
                              itemCount: catProducts.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                AllProducts prod = catProducts[index];
                                return Row(children: [
                                  Container(
                                      width: width > 600
                                          ? width * 0.25
                                          : width * 0.4,
                                      color: themeColor.primary,
                                      child: MaterialButton(
                                          onPressed: () {},
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: 170,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Image.network(
                                                        prod.image!)),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(prod.title!,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontFamily: "M600",
                                                        fontSize: 16)),
                                                SizedBox(
                                                    width: 134,
                                                    child: Text(
                                                        prod.description!,
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: const TextStyle(
                                                            fontFamily: "M500",
                                                            fontSize: 10))),
                                                Text(
                                                    "\$${prod.price!.toString()}",
                                                    style: const TextStyle(
                                                        fontFamily: "M500",
                                                        fontSize: 12)),
                                                Row(children: [
                                                  StarRating(
                                                    rating: double.parse(prod
                                                        .rating!.count!
                                                        .toString()),
                                                    color:
                                                        CommonColors.ratingStar,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                      prod.rating!.count!
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          fontFamily: "M500",
                                                          color: CommonColors
                                                              .greyC))
                                                ])
                                              ]))),
                                  const SizedBox(width: 16)
                                ]);
                              });
                        }))
              ]);
            }
          }),
    );
  }

  shopButton(
      Color color1, Color color2, Image icon, String text, AllProducts prod) {
    return GestureDetector(
      onTap: () {
        if (text == "Buy Now") {
        } else if (text == "Add to cart") {
          addToCart(prod, context);
        }
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
                } else if (text == "Add to cart") {
                  addToCart(prod, context);
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
                    if (text == "Buy Now") {
                    } else if (text == "Add to cart") {
                      addToCart(prod, context);
                    }
                  },
                  icon: icon),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addToCart(AllProducts prod, BuildContext context) async {
    CartProduct cart =
        CartProduct(userId: 1, date: DateTime.now().toString(), products: [
      Products(productId: prod.id, quantity: 1),
    ]);
    CartProduct? result = await cartApi.addToCart(cart);
    if (context.mounted) {
      if (result != null) {
        const snackBar = SnackBar(content: Text("Added To cart"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(content: Text("Failed"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
