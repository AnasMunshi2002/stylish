import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

import '../../../models/screen_models/shopping_list_product.dart';
import '../../../services/static_data/static_data.dart';
import '../../../view_models/theme_provider/colors/common.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../../widgets/assets/icons/app_icons.dart';
import '../../widgets/responsive_size/responsive_size.dart';
import '../../widgets/text/texts.dart';
import '../shop/place_order/place_order.dart';


class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context
        .watch<ThemeProvider>()
        .currentTheme
        .colorScheme;
    return Scaffold(
      backgroundColor: themeColor.primary,
      appBar: AppBar(
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
                    AppIcons.backIcon,
                    color: themeColor.secondary,
                    scale: ResponsiveSize.getScale(context),
                  ))),
          backgroundColor: themeColor.primary,
          centerTitle: true,
          title: const Text(
            "Checkout",
            style: TextStyle(fontFamily: "M600", fontSize: 18),
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Image.asset(
                    color: themeColor.secondary,
                    AppIcons.address,
                    scale: ResponsiveSize.getScale(context)),
                const SizedBox(width: 7),
                TextWidget(
                  text: "Delivery Address",
                  color: themeColor.secondary,
                  fontFamily: "M600",
                  fontSize: ResponsiveSize.getSmallFont(context),
                )
              ]),
              const SizedBox(height: 10),
              SizedBox(
                  height: MediaQuery
                      .of(context)
                      .devicePixelRatio * 40,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: themeColor.primary,
                                    boxShadow: const [
                                      BoxShadow(
                                          spreadRadius: -8,
                                          offset: Offset(0, 6),
                                          blurRadius: 14,
                                          color: Color(0xffabadb3ff)),
                                      BoxShadow(
                                          spreadRadius: -7,
                                          offset: Offset(0, -4),
                                          blurRadius: 9,
                                          color: Color(0xffabadb3ff))
                                    ]),
                                padding: const EdgeInsets.all(12),
                                child: Stack(children: [
                                  Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Address:",
                                            style: TextStyle(
                                                fontFamily: "M600",
                                                fontSize: ResponsiveSize
                                                    .getNavBarFont(context)
                                                    .toDouble())),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                            child: Text(
                                                "216 St Paul's Rd, London N1 2LL, UK Contact :  +44-784232",
                                                style: TextStyle(
                                                    fontFamily: "M500",
                                                    fontSize: ResponsiveSize
                                                        .getSmallFont(
                                                        context)
                                                        .toDouble() *
                                                        0.85)))
                                      ]),
                                  Positioned(
                                    right: 0,
                                    child: GestureDetector(
                                        onTap: () {},
                                        child: Image.asset(
                                            color: themeColor.secondary,
                                            AppIcons.editAddress)),
                                  )
                                ]))),
                        const SizedBox(width: 20),
                        Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  spreadRadius: -8,
                                  offset: Offset(0, 6),
                                  blurRadius: 14,
                                  color: Color(0xffabadb3ff)),
                              BoxShadow(
                                  spreadRadius: -7,
                                  offset: Offset(0, -4),
                                  blurRadius: 9,
                                  color: Color(0xffabadb3ff))
                            ]),
                            child: IconButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(6))),
                                    backgroundColor: WidgetStatePropertyAll(
                                        themeColor.primary),
                                    padding: const WidgetStatePropertyAll(
                                        EdgeInsets.all(27))),
                                onPressed: () {},
                                icon: Image.asset("assets/icons/Group-add.png",
                                    color: themeColor.secondary)))
                      ])),
              const SizedBox(height: 24),
              Text(
                "Shopping List",
                style: TextStyle(
                    fontFamily: "M600",
                    fontSize: ResponsiveSize.getSmallFont(context).toDouble()),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: ResponsiveSize.getCartContainerHeight(context),
                child: Scrollbar(
                  interactive: true,
                  thickness: 6,
                  radius: const Radius.circular(13),
                  trackVisibility: true,
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: StaticData.shoppingList.length,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        ShoppingListProduct prod =
                        StaticData.shoppingList[index];

                        return Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: themeColor.primary,
                                    boxShadow: const [
                                      BoxShadow(
                                          spreadRadius: -8,
                                          offset: Offset(0, 6),
                                          blurRadius: 14,
                                          color: Color(0xffabadb3ff)),
                                      BoxShadow(
                                          spreadRadius: -7,
                                          offset: Offset(0, -4),
                                          blurRadius: 9,
                                          color: Color(0xffabadb3ff))
                                    ]),
                                padding: const EdgeInsets.all(10),
                                child: MaterialButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlaceOrder(product: prod)));
                                    },
                                    child: Column(children: [
                                      Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    .18,
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    .16,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.fitWidth,
                                                        image: AssetImage(
                                                          prod.image,
                                                        )),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        4))),
                                            const SizedBox(width: 9),
                                            Expanded(
                                              child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 7),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                            softWrap: true,
                                                            prod.title,
                                                            style: TextStyle(
                                                              fontFamily:
                                                              "M600",
                                                              fontSize: ResponsiveSize
                                                                  .getSmallFont(
                                                                  context)
                                                                  .toDouble(),
                                                            )),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Variations : ",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                "M500",
                                                                fontSize: ResponsiveSize
                                                                    .getSmallFont(
                                                                    context)
                                                                    .toDouble(),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.05,
                                                                width: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.09,
                                                                child:
                                                                OutlinedButton(
                                                                    style: ButtonStyle(
                                                                        padding:
                                                                        const WidgetStatePropertyAll(
                                                                            EdgeInsets
                                                                                .all(
                                                                                0)),
                                                                        shape: WidgetStatePropertyAll(
                                                                            RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    3)))),
                                                                    onPressed: () {},
                                                                    child: Text(
                                                                      prod
                                                                          .variations[
                                                                      0],
                                                                      style: TextStyle(
                                                                          fontFamily: "M500",
                                                                          fontSize: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .width >=
                                                                              576
                                                                              ? (MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .width *
                                                                              0.02)
                                                                              : (MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .width *
                                                                              0.025),
                                                                          color: themeColor
                                                                              .secondary),
                                                                    ))),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.05,
                                                              width: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.09,
                                                              child:
                                                              OutlinedButton(
                                                                  style: ButtonStyle(
                                                                      padding: const WidgetStatePropertyAll(
                                                                          EdgeInsets
                                                                              .all(
                                                                              0)),
                                                                      shape: WidgetStatePropertyAll(
                                                                          RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius
                                                                                  .circular(
                                                                                  3)))),
                                                                  onPressed:
                                                                      () {},
                                                                  child:
                                                                  Text(
                                                                    prod
                                                                        .variations[
                                                                    1],
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        "M500",
                                                                        fontSize: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width >=
                                                                            576
                                                                            ? (MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width *
                                                                            0.02)
                                                                            : (MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .width *
                                                                            0.025),
                                                                        color: themeColor
                                                                            .secondary),
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(children: [
                                                          Text(
                                                            prod.rating,
                                                            style: TextStyle(
                                                              fontFamily:
                                                              "M500",
                                                              fontSize: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width >=
                                                                  576
                                                                  ? (MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.024)
                                                                  : (MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.03),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          StarRating(
                                                              rating: double
                                                                  .parse(prod
                                                                  .rating),
                                                              color:
                                                              CommonColors
                                                                  .ratingStar,
                                                              size: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width >=
                                                                  576
                                                                  ? (MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.028)
                                                                  : (MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.04))
                                                        ]),
                                                        Row(children: [
                                                          Container(
                                                              alignment: Alignment
                                                                  .center,
                                                              height: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width *
                                                                  0.1,
                                                              width: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width *
                                                                  0.2205,
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  10,
                                                                  vertical: 9),
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                      color: const Color(
                                                                          0xffCACACA),
                                                                      width:
                                                                      0.3),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      4)),
                                                              child: Text(
                                                                  "\$ ${prod
                                                                      .price
                                                                      .toDouble()
                                                                      .toStringAsFixed(
                                                                      2)}",
                                                                  style: TextStyle(
                                                                      fontFamily: "M600",
                                                                      fontSize: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .width *
                                                                          0.035))),
                                                          const SizedBox(
                                                              width: 11),
                                                          Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  "upto ${prod
                                                                      .discount
                                                                      .toString()}% off",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      "M600",
                                                                      fontSize: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .width *
                                                                          0.025,
                                                                      color: CommonColors
                                                                          .navBarActive),
                                                                ),
                                                                Text(
                                                                    "\$ ${prod
                                                                        .originalPrice
                                                                        .toDouble()
                                                                        .toStringAsFixed(
                                                                        2)}",
                                                                    style:
                                                                    TextStyle(
                                                                      fontFamily:
                                                                      "M500",
                                                                      decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                      decorationColor:
                                                                      themeColor
                                                                          .secondary,
                                                                      fontSize: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .width *
                                                                          0.035,
                                                                      color: themeColor
                                                                          .secondary,
                                                                    ))
                                                              ])
                                                        ])
                                                      ])),
                                            )
                                          ]),
                                      const Divider(indent: 10, endIndent: 10),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Order (${prod
                                                  .orderNo})  :",
                                              style: TextStyle(
                                                fontFamily: "M500",
                                                fontSize:
                                                ResponsiveSize.getSmallFont(
                                                    context)
                                                    .toDouble(),
                                              ),
                                            ),
                                            Text(
                                                "\$ ${(prod.orderNo *
                                                    prod.price.toDouble())
                                                    .toStringAsFixed(2)} ",
                                                style: TextStyle(
                                                  fontFamily: "M600",
                                                  fontSize: ResponsiveSize
                                                      .getSmallFont(context)
                                                      .toDouble(),
                                                ))
                                          ])
                                    ]))),
                            const SizedBox(height: 20)
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
