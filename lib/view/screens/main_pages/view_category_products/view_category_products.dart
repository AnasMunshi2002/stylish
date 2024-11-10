import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../models/api_models/all_products/all_products.dart';
import '../../../../services/api/fetch_categories/fetch_categories.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/text/texts.dart';
import '../../view_product/view_product.dart';

class ViewCategoryProducts extends StatefulWidget {
  final String category;

  const ViewCategoryProducts({required this.category, super.key});

  @override
  State<ViewCategoryProducts> createState() => _ViewCategoryProductsState();
}

class _ViewCategoryProductsState extends State<ViewCategoryProducts> {
  final FetchCategories fetchCategories = FetchCategories();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
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
        title: TextWidget(text: widget.category, color: themeColor.secondary),
        backgroundColor: themeColor.primary,
      ),
      body: FutureBuilder(
          future: fetchCategories.getCategoryProducts(widget.category),
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
              return SingleChildScrollView(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
                  child: StaggeredGrid.count(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    crossAxisCount: width >= 650 ? 3 : 2,
                    children: List.generate(list.length, (index) {
                      AllProducts prod = list[index];
                      return MaterialButton(
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
                                  width: ResponsiveSize.getWidth(context) * 10,
                                  child: Image.network(prod.image!,
                                      fit: BoxFit.fill)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontSize: ResponsiveSize.getSmallFont(
                                                  context)
                                              .toDouble()),
                                    ),
                                    const SizedBox(height: 6),
                                    TextWidget(
                                        text: "\$${prod.price!.toString()}",
                                        color: themeColor.secondary,
                                        fontFamily: "M500",
                                        fontSize: ResponsiveSize.getMediumFont(
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
                                            text: prod.rating!.count.toString(),
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
                ),
              );
            }
          }),
    );
  }
}
