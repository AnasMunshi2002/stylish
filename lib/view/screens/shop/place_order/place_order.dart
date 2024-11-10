import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/screen_models/shopping_list_product.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/buttons/filled_button.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/tb/tb.dart';
import '../ship/shipping.dart';

class PlaceOrder extends StatefulWidget {
  final ShoppingListProduct product;

  const PlaceOrder({required this.product, super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  late ShoppingListProduct product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return Scaffold(
      backgroundColor: themeColor.primary,
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                size: ResponsiveSize.getLargeFont(context).toDouble(),
              ))
        ],
        backgroundColor: themeColor.primary,
        title: Text("Shopping Bag",
            style: TextStyle(
                fontFamily: "M600",
                fontSize:
                    ResponsiveSize.getMediumLargeFont(context).toDouble())),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 17, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(product.image))),
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    const SizedBox(
                      width: 21,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 7, right: 10, top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                  fontFamily: "M600",
                                  fontSize:
                                      ResponsiveSize.getMediumFont(context)
                                          .toDouble()),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              softWrap: true,
                              product.desc,
                              style: TextStyle(
                                  fontFamily: "M500",
                                  fontSize: ResponsiveSize.getSmallFont(context)
                                      .toDouble()),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration:
                                      BoxDecoration(color: themeColor.primary),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Size",
                                        style: TextStyle(
                                          fontFamily: "M500",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "42",
                                        style: TextStyle(
                                          fontFamily: "M500",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                      Expanded(
                                        child: MaterialButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {},
                                          child: Container(
                                              padding: const EdgeInsets.all(0),
                                              transform:
                                                  Matrix4.translationValues(
                                                      0, -7, 0),
                                              child: Image.asset(
                                                "assets/icons/view_Vector 33 (1).png",
                                                color: themeColor.secondary,
                                                scale: MediaQuery.of(context)
                                                            .size
                                                            .width >=
                                                        600
                                                    ? 2
                                                    : 3,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration:
                                      BoxDecoration(color: themeColor.primary),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Qty",
                                        style: TextStyle(
                                          fontFamily: "M500",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width >=
                                                    600
                                                ? 20
                                                : 10,
                                      ),
                                      Text(
                                        product.orderNo.toString(),
                                        style: TextStyle(
                                          fontFamily: "M500",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                      Expanded(
                                        child: MaterialButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {},
                                          child: Container(
                                              padding: const EdgeInsets.all(0),
                                              transform:
                                                  Matrix4.translationValues(
                                                      0, -7, 0),
                                              child: Image.asset(
                                                "assets/icons/view_Vector 33 (1).png",
                                                color: themeColor.secondary,
                                                scale: MediaQuery.of(context)
                                                            .size
                                                            .width >=
                                                        600
                                                    ? 2
                                                    : 3,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Delivery By  ",
                                  style: TextStyle(
                                    fontFamily: "M400",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  ),
                                ),
                                Text(
                                  "10May 2XXX",
                                  style: TextStyle(
                                    fontFamily: "M600",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/coupon.png",
                              color: themeColor.secondary,
                              scale: MediaQuery.of(context).size.width >= 600
                                  ? 1.4
                                  : 2,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Apply Coupons",
                              style: TextStyle(
                                fontFamily: "M500",
                                fontSize: MediaQuery.of(context).size.width >=
                                        600
                                    ? MediaQuery.of(context).size.width * 0.028
                                    : MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                          ],
                        ),
                        TB(
                          style: const ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(0))),
                          event: () {},
                          text: "Select",
                          weight: "M600",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Divider(
                      thickness:
                          MediaQuery.of(context).size.width >= 600 ? 2 : 1,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Order payment Details",
                      style: TextStyle(
                        fontFamily: "M500",
                        fontSize: MediaQuery.of(context).size.width >= 600
                            ? MediaQuery.of(context).size.width * 0.028
                            : MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Amount Details",
                          style: TextStyle(
                            fontFamily: "M400",
                            fontSize: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.028
                                : MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                        Text(
                          "₹ 7,000",
                          style: TextStyle(
                            fontFamily: "M500",
                            fontSize: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.028
                                : MediaQuery.of(context).size.width * 0.035,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Convenience",
                              style: TextStyle(
                                fontFamily: "M400",
                                fontSize: MediaQuery.of(context).size.width >=
                                        600
                                    ? MediaQuery.of(context).size.width * 0.028
                                    : MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            TB(
                              weight: "M600",
                              event: () {},
                              text: "Know More",
                              style: const ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.all(0))),
                            ),
                          ],
                        ),
                        TB(
                          event: () {},
                          text: "Apply Coupon",
                          style: const ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(0))),
                          weight: "M600",
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Fee",
                          style: TextStyle(
                            fontFamily: "M400",
                            fontSize: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.028
                                : MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.end,
                          "Free",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width >= 600
                                  ? MediaQuery.of(context).size.width * 0.024
                                  : MediaQuery.of(context).size.width * 0.032,
                              fontFamily: "M600",
                              color: const Color(0xffF83758)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Divider(
                      thickness:
                          MediaQuery.of(context).size.width >= 600 ? 2 : 1,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Total",
                          style: TextStyle(
                            fontFamily: "M600",
                            fontSize: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.03
                                : MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Text(
                          "₹ 7,000",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.03
                                : MediaQuery.of(context).size.width * 0.04,
                            fontFamily: "M600",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "EMI Available",
                          style: TextStyle(
                            fontFamily: "M400",
                            fontSize: MediaQuery.of(context).size.width >= 600
                                ? MediaQuery.of(context).size.width * 0.026
                                : MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        TB(
                          event: () {},
                          text: "Details",
                          style: const ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(0))),
                          weight: "M600",
                        )
                      ],
                    ),
                    const SizedBox(height: 130),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width >= 576 ? 2 : 1),
            height: 105,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: CommonColors.greyC,
                    offset: Offset(0, -0.5),
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24), topLeft: Radius.circular(24)),
              color: CommonColors.greyC,
            ),
            child: Container(
              height: 109,
              padding: const EdgeInsets.only(top: 32, left: 22, right: 22),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: themeColor.secondary,
                      offset: const Offset(0, -0.5),
                      spreadRadius: 1)
                ],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24)),
                color: themeColor.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "₹7,000",
                        style: TextStyle(
                            fontSize: ResponsiveSize.getMediumFont(context)
                                .toDouble(),
                            fontFamily: "M600"),
                      ),
                      GestureDetector(
                        child: Text(
                          "View Details",
                          style: TextStyle(
                              fontSize: ResponsiveSize.getSmallFont(context)
                                  .toDouble(),
                              fontFamily: "M700",
                              color: CommonColors.buttonColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 13),
                      child: ColoredButton(
                        event: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ShippingPage()));
                        },
                        padding: const EdgeInsets.all(13),
                        borderRadius: 8,
                        backColor: CommonColors.buttonColor,
                        text: "Proceed to Payment",
                        fontFamily: "M500",
                        fontSize: ResponsiveSize.getMediumFont(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
