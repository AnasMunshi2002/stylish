import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../models/api_models/all_products/all_products.dart';
import '../../../../services/api/all_product/http_get_all.dart';
import '../../../../services/api/product/add_product/add_product.dart';
import '../../../../services/api/sort/sort_api.dart';
import '../../../../view_models/product_provider/add_product_provider/add_provider.dart';
import '../../../../view_models/sort_provider/sort_provider.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/buttons/filled_button.dart';
import '../../../widgets/filter_button/filter_button.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/searchbar/search_bar.dart';
import '../../../widgets/sort_button/sort_button.dart';
import '../../../widgets/text/texts.dart';
import '../../sell/add/add_product.dart';
import '../../view_product/view_product.dart';

class TrendingProducts extends StatefulWidget {
  const TrendingProducts({super.key});

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {
  final _searchController = TextEditingController();
  final HttpGetAll _getAll = HttpGetAll();
  final SortAPI sortAPI = SortAPI();

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final fieldProvider = Provider.of<AddProductProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: MediaQuery.of(context).size.width * 0.1,
              child: SearchBox(controller: _searchController)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextWidget(
              text: "52,082+ Items",
              fontFamily: "M600",
              fontSize: ResponsiveSize.getMediumLargeFont(context),
              color: themeColor.secondary,
            ),
            Row(children: [
              const SortingButton(),
              SizedBox(width: ResponsiveSize.getNavBarFont(context).toDouble()),
              const FilterButton()
            ])
          ]),
          FutureBuilder(
              future: context.watch<SortProvider>().isSorted
                  ? sortAPI.getSortedProducts()
                  : _getAll.getProducts(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LottieBuilder.asset(
                        "assets/animations/tile Animation - 1729678421492.json"),
                  );
                } else if (snapshots.data!.isEmpty) {
                  return Center(
                    child: TextWidget(
                      text: "NO DATA FETCHED",
                      color: themeColor.secondary,
                      fontSize: 20,
                    ),
                  );
                } else {
                  List<AllProducts> list = snapshots.data!;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: StaggeredGrid.count(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: width >= 650 ? 3 : 2,
                      children: List.generate(list.length, (index) {
                        AllProducts prod = list[index];
                        return MaterialButton(
                          onLongPress: () {
                            showPopupMenu(
                                context, prod, themeColor, fieldProvider);
                          },
                          padding: const EdgeInsets.all(0),
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProduct(
                                          id: prod.id!,
                                        )));
                          },
                          color: themeColor.primaryFixed,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width:
                                        ResponsiveSize.getWidth(context) * 10,
                                    child: Image.network(prod.image!,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingEvent) {
                                      if (loadingEvent == null) {
                                        return child;
                                      }
                                      return SizedBox(
                                        height: 200,
                                        width: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingEvent
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingEvent
                                                        .cumulativeBytesLoaded /
                                                    loadingEvent
                                                        .expectedTotalBytes!
                                                : null,
                                            color: themeColor.secondary,
                                          ),
                                        ),
                                      );
                                    }, fit: BoxFit.fill)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        prod.title!,
                                        style: TextStyle(
                                            color: themeColor.secondary,
                                            fontFamily: "M500",
                                            fontSize:
                                                ResponsiveSize.getMediumFont(
                                                        context)
                                                    .toDouble()),
                                      ),
                                      Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        prod.description!,
                                        style: TextStyle(
                                            color: themeColor.secondary,
                                            fontSize:
                                                ResponsiveSize.getSmallFont(
                                                        context)
                                                    .toDouble()),
                                      ),
                                      const SizedBox(height: 6),
                                      TextWidget(
                                          text: "\$${prod.price!.toString()}",
                                          color: themeColor.secondary,
                                          fontFamily: "M500",
                                          fontSize:
                                              ResponsiveSize.getMediumFont(
                                                  context)),
                                      Row(
                                        children: [
                                          StarRating(
                                              color: CommonColors.ratingStar,
                                              size: width >= 576
                                                  ? (width * 0.028)
                                                  : (width * 0.04),
                                              rating: prod.rating!.rate!),
                                          const SizedBox(width: 10),
                                          TextWidget(
                                              text:
                                                  prod.rating!.count.toString(),
                                              fontSize:
                                                  ResponsiveSize.getSmallFont(
                                                      context),
                                              fontFamily: "M500",
                                              color: themeColor.secondary)
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        );
                      }),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Future<void> showPopupMenu(BuildContext context, AllProducts prod,
      ColorScheme themeColor, AddProductProvider fieldProvider) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: themeColor.primary,
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        fieldProvider.initProgress();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProduct(
                                      product: prod,
                                    )));
                        fieldProvider.changeCategory(prod.category!);
                      },
                      leading: const Icon(Icons.update),
                      title: TextWidget(
                          text: "Update product", color: themeColor.secondary),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _confirmDelete(prod, context, themeColor);
                      },
                      leading: const Icon(
                        Icons.delete_forever_outlined,
                        color: CommonColors.navBarActive,
                      ),
                      title: const TextWidget(
                          text: "Delete product",
                          color: CommonColors.navBarActive),
                    ),
                  ],
                ),
              ),
            ));
  }

  Future<void> _confirmDelete(
    AllProducts product,
    BuildContext context,
    ColorScheme themeColor,
  ) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: themeColor.primary,
              title: TextWidget(
                text: "Are your Sure?",
                color: themeColor.secondary,
                fontSize: ResponsiveSize.getMediumLargeFont(context),
                fontFamily: "M400",
              ),
              content: TextWidget(
                text: "Delete this product",
                color: themeColor.secondary,
                fontFamily: "M400",
                fontSize: ResponsiveSize.getSmallFont(context),
              ),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColoredButton(
                        fontColor: themeColor.secondary,
                        text: "N o",
                        backColor: Colors.transparent,
                        fontFamily: "M400",
                        event: () {
                          Navigator.pop(context);
                        },
                        fontSize: ResponsiveSize.getSmallFont(context)),
                    ColoredButton(
                        text: "Y e s",
                        backColor: CommonColors.navBarActive,
                        fontFamily: "M400",
                        event: () async {
                          AddProductAPI addAPI = AddProductAPI();
                          AllProducts? result =
                              await addAPI.deleteProduct(product);
                          if (context.mounted) {
                            Navigator.pop(context);
                            if (result != null) {
                              print(result.id);
                              const snackBar = SnackBar(
                                  content:
                                      Text("Product deleted Successfully "));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              const snackBar =
                                  SnackBar(content: Text("Unable to delete "));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        fontSize: ResponsiveSize.getSmallFont(context))
                  ],
                )
              ],
            ));
  }
}
