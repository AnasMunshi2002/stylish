import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

import '../../../../models/api_models/all_products/all_products.dart';
import '../../../../models/api_models/cart/cart_api_model/cart_api_model.dart';
import '../../../../services/api/all_product/http_get_all.dart';
import '../../../../services/api/cart/all_cart/cart_api_all.dart';
import '../../../../services/api/cart/sort_cart/sort_cart_api.dart';
import '../../../../view_models/product_provider/cart_provider/cart_provider.dart';
import '../../../../view_models/sort_provider/sort_provider.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/assets/icons/app_icons.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/text/texts.dart';

class AllCart extends StatefulWidget {
  const AllCart({super.key});

  @override
  State<AllCart> createState() => _AllCartState();
}

class _AllCartState extends State<AllCart> {
  late final ScrollController _scrollController;
  final HttpGetAll getAll = HttpGetAll();
  final AllCartAPI cartAPI = AllCartAPI();
  late List<AllProducts> allProducts;
  SortCartAPI sortCart = SortCartAPI();

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 0);
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
        backgroundColor: themeColor.primary,
        title: TextWidget(text: "All Cart", color: themeColor.secondary),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shopping List",
                  style: TextStyle(
                      fontFamily: "M600",
                      fontSize:
                          ResponsiveSize.getSmallFont(context).toDouble()),
                ),
                SizedBox(
                  height: ResponsiveSize.sortButtonHeight(context),
                  width: ResponsiveSize.sortButtonWidth(context),
                  child: FilledButton(
                      style: ButtonStyle(
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.all(0)),
                          elevation: const WidgetStatePropertyAll(10),
                          backgroundColor:
                              WidgetStatePropertyAll(themeColor.primary),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)))),
                      onPressed: () {
                        context.read<SortProvider>().changeSortCartPref();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                              text: "Sort",
                              fontFamily: "M500",
                              fontSize: ResponsiveSize.getSmallFont(context),
                              color: themeColor.secondary),
                          Image.asset(
                            AppIcons.sort,
                            scale: 2,
                            color: themeColor.secondary,
                          )
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                  future: getAll.getProducts(),
                  builder: (context, snapshotOuter) {
                    if (snapshotOuter.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: themeColor.secondary,
                        ),
                      );
                    } else if (!snapshotOuter.hasData) {
                      return Center(
                        child: TextWidget(
                            text: "Unable to Fetch",
                            color: themeColor.secondary),
                      );
                    }
                    allProducts = snapshotOuter.data!;
                    return FutureBuilder(
                        future: context.watch<SortProvider>().isCartSorted
                            ? sortCart.getSortedCartProduct("desc")
                            : cartAPI.getCartProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: themeColor.secondary,
                              ),
                            );
                          } else if (!snapshot.hasData) {
                            return Center(
                              child: TextWidget(
                                  text: "Unable to Fetch",
                                  color: themeColor.secondary),
                            );
                          }
                          List<CartProduct> cartItems = snapshot.data!;

                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Scrollbar(
                              controller: _scrollController,
                              interactive: true,
                              thickness: 6,
                              radius: const Radius.circular(13),
                              trackVisibility: true,
                              thumbVisibility: true,
                              child: Consumer<CartProvider>(
                                  builder: (context, consumer, child) {
                                return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: cartItems.length,
                                  itemBuilder: (context, indexOuter) {
                                    consumer.cartItems = cartItems;
                                    CartProduct cartItem =
                                        consumer.cartItems[indexOuter];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                                text:
                                                    "Cart : ${indexOuter + 1}",
                                                fontSize: ResponsiveSize
                                                    .getMediumLargeFont(
                                                        context),
                                                fontFamily: "M500",
                                                color: themeColor.secondary),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18.0),
                                              child: IconButton.filled(
                                                onPressed: () async {
                                                  CartProduct? result =
                                                      await cartAPI
                                                          .deleteCart(cartItem);
                                                  print(result!.id);
                                                  const snackBar = SnackBar(
                                                      content:
                                                          Text("Cart deleted"));
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                },
                                                icon: const Icon(Icons.delete),
                                                style: ButtonStyle(
                                                    shape: WidgetStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                    backgroundColor:
                                                        const WidgetStatePropertyAll(
                                                            CommonColors
                                                                .navBarActive)),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                cartItem.products!.length,
                                            itemBuilder: (context, index) {
                                              AllProducts prod = allProducts
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      cartItem.products![index]
                                                          .productId);
                                              return Column(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: themeColor
                                                              .primary,
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                spreadRadius:
                                                                    -8,
                                                                offset: Offset(
                                                                    0, 6),
                                                                blurRadius: 14,
                                                                color: Color(
                                                                    0xffabadb3ff)),
                                                            BoxShadow(
                                                                spreadRadius:
                                                                    -7,
                                                                offset: Offset(
                                                                    0, -4),
                                                                blurRadius: 9,
                                                                color: Color(
                                                                    0xffabadb3ff))
                                                          ]),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: MaterialButton(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          onPressed: () {
                                                            /*Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PlaceOrder(product: prod)));*/
                                                          },
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                          height: MediaQuery.of(context).size.height *
                                                                              .18,
                                                                          width:
                                                                              MediaQuery.of(context).size.height * .16,
                                                                          decoration: BoxDecoration(
                                                                              image: DecorationImage(
                                                                                  fit: BoxFit.fitWidth,
                                                                                  image: NetworkImage(
                                                                                    prod.image!,
                                                                                  )),
                                                                              borderRadius: BorderRadius.circular(4))),
                                                                      const SizedBox(
                                                                          width:
                                                                              9),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 7),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                  softWrap: true,
                                                                                  prod.title!,
                                                                                  style: TextStyle(
                                                                                    fontFamily: "M600",
                                                                                    fontSize: ResponsiveSize.getSmallFont(context).toDouble(),
                                                                                  )),
                                                                              const SizedBox(
                                                                                height: 7,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    prod.rating!.rate!.toString(),
                                                                                    style: TextStyle(
                                                                                      fontFamily: "M500",
                                                                                      fontSize: MediaQuery.of(context).size.width >= 576 ? (MediaQuery.of(context).size.width * 0.024) : (MediaQuery.of(context).size.width * 0.03),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 5),
                                                                                  StarRating(
                                                                                    rating: double.parse(prod.rating!.rate!.toString()),
                                                                                    color: CommonColors.ratingStar,
                                                                                    size: MediaQuery.of(context).size.width >= 576 ? (MediaQuery.of(context).size.width * 0.028) : (MediaQuery.of(context).size.width * 0.04),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Container(
                                                                                    alignment: Alignment.center,
                                                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                                                    width: MediaQuery.of(context).size.width * 0.2205,
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                                                                                    decoration: BoxDecoration(border: Border.all(color: const Color(0xffCACACA), width: 0.3), borderRadius: BorderRadius.circular(4)),
                                                                                    child: Text(
                                                                                      "\$ ${prod.price!.toDouble().toStringAsFixed(2)}",
                                                                                      style: TextStyle(
                                                                                        fontFamily: "M600",
                                                                                        fontSize: MediaQuery.of(context).size.width * 0.035,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 11),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Visibility(
                                                                                    visible: cartItem.products![index].quantity! > 0,
                                                                                    child: IconButton(
                                                                                        onPressed: () async {
                                                                                          consumer.updateQuantity(cartItem.id!, (cartItem.products![index].quantity! - 1), prod.id!);
                                                                                          bool result = await updateCart(cartItem);
                                                                                          if (context.mounted) {
                                                                                            if (result) {
                                                                                              const snackBar = SnackBar(content: Text("Cart Updated!!"));

                                                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                            } else {
                                                                                              const snackBar = SnackBar(content: Text("Failed to update !!"));

                                                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                            }
                                                                                          }
                                                                                        },
                                                                                        color: themeColor.secondary,
                                                                                        icon: Icon(
                                                                                          Icons.remove,
                                                                                          size: ResponsiveSize.getSmallFont(context).toDouble(),
                                                                                        )),
                                                                                  ),
                                                                                  TextWidget(
                                                                                    text: "${cartItem.products?[index].quantity}",
                                                                                    fontFamily: "M300",
                                                                                    color: themeColor.secondary,
                                                                                  ),
                                                                                  IconButton(
                                                                                    onPressed: () async {
                                                                                      consumer.updateQuantity(cartItem.id!, (cartItem.products![index].quantity! + 1), prod.id!);
                                                                                      bool result = await updateCart(cartItem);
                                                                                      if (context.mounted) {
                                                                                        if (result) {
                                                                                          const snackBar = SnackBar(content: Text("Cart Updated!!"));
                                                                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                        } else {
                                                                                          const snackBar = SnackBar(content: Text("Failed to update!!"));
                                                                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                    icon: Icon(
                                                                                      Icons.add,
                                                                                      size: ResponsiveSize.getSmallFont(context).toDouble(),
                                                                                      color: themeColor.secondary,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                                const Divider(
                                                                    indent: 10,
                                                                    endIndent:
                                                                        10),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        "Total Order (${cartItem.products![index].quantity})  :",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              "M500",
                                                                          fontSize:
                                                                              ResponsiveSize.getSmallFont(context).toDouble(),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                          "\$ ${(cartItem.products![index].quantity! * prod.price!.toDouble()).toStringAsFixed(2)} ",
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "M600",
                                                                            fontSize:
                                                                                ResponsiveSize.getSmallFont(context).toDouble(),
                                                                          ))
                                                                    ])
                                                              ]))),
                                                  const SizedBox(height: 20)
                                                ],
                                              );
                                            }),
                                      ],
                                    );
                                  },
                                );
                              }),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> updateCart(CartProduct cartItem) async {
    CartProduct? result = await cartAPI.updateCart(cartItem);
    if (result != null) {
      return true;
    }
    return false;
  }
}
