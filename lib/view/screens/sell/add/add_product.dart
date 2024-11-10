import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/api_models/all_products/all_products.dart';
import '../../../../services/api/product/add_product/add_product.dart';
import '../../../../view_models/product_provider/add_product_provider/add_provider.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/buttons/filled_button.dart';
import '../../../widgets/category_buttons/category_buttons.dart';
import '../../../widgets/responsive_size/responsive_size.dart';
import '../../../widgets/text/texts.dart';
import '../../../widgets/tf/add_product/add_product_tf.dart';

class AddProduct extends StatefulWidget {
  final AllProducts? product;

  const AddProduct({this.product, super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _imageLinkController = TextEditingController();
  late final ScrollController _scrollController;
  final AddProductAPI addProductAPi = AddProductAPI();
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;
  AllProducts? product;
  final _priceController = TextEditingController();

  @override
  void initState() {
    if (widget.product != null) {
      product = widget.product;
      _titleController.text = product!.title!;
      _descController.text = product!.description!;
      _imageLinkController.text = product!.image!;
      _priceController.text = product!.price!.toString();
    }
    _scrollController = ScrollController(initialScrollOffset: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fieldProvider = Provider.of<AddProductProvider>(context);
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
        title: TextWidget(
            text: "Add Product",
            fontFamily: "M500",
            fontSize: ResponsiveSize.getMediumFont(context),
            color: themeColor.secondary),
      ),
      body: ListView(
        children: [
          Column(
            children: product == null
                ? [
                    Padding(
                      padding: EdgeInsets.all(
                          ResponsiveSize.getMediumLargeFont(context)
                              .toDouble()),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: fieldProvider.progress,
                                backgroundColor:
                                    themeColor.secondary == CommonColors.blackC
                                        ? CommonColors.greyC
                                        : themeColor.secondary,
                                color: CommonColors.buttonColor,
                              ),
                              TextWidget(
                                  text: "${fieldProvider.fieldsCompleted}/5",
                                  color: themeColor.secondary)
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          TextWidget(
                            text: "Add a Product to your Shop",
                            color: themeColor.secondary,
                            fontFamily: "M500",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveSize.getWidth(context),
                    ),
                  ]
                : [],
          ),
          Container(
            padding: EdgeInsets.all(
                ResponsiveSize.getMediumLargeFont(context).toDouble()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: "Select Category",
                  color: themeColor.secondary,
                  fontFamily: "M500",
                  fontSize: ResponsiveSize.getMediumFont(context),
                ),
                SizedBox(
                  height: ResponsiveSize.getSmallFont(context).toDouble(),
                ),
                Container(
                  alignment: Alignment.center,
                  height: ResponsiveSize.pageViewHeight(context) * 0.7,
                  child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 6,
                          mainAxisExtent:
                              ResponsiveSize.buttonHeight(context) * 2.3,
                          crossAxisCount: 4),
                      children: const [
                        CategoryButtons(
                          image: "assets/logo/wedding-ring_9215666.png",
                          categoryString: "jewelery",
                          label: "Jewelery",
                        ),
                        CategoryButtons(
                          image: "assets/logo/computer-desktop-icon.png",
                          categoryString: "electronics",
                          label: "Electronic",
                        ),
                        CategoryButtons(
                          image: "assets/logo/frock_17514714.png",
                          categoryString: "women's clothing",
                          label: "Women's",
                        ),
                        CategoryButtons(
                          image: "assets/logo/man_11107362.png",
                          categoryString: "men's clothing",
                          label: "Men's",
                        ),
                      ]),
                ),
                TextWidget(
                    text: "Enter below details : ",
                    fontFamily: "M500",
                    fontSize: ResponsiveSize.getMediumFont(context),
                    color: themeColor.secondary),
                const SizedBox(
                  height: 14,
                ),
                ProductTextField(
                    inputType: TextInputType.text,
                    hint: "Product Title",
                    event: (value) {
                      if (value.isNotEmpty) {
                        if (count1 == 0) {
                          fieldProvider.increaseField();
                          count1++;
                        }
                      } else {
                        count1--;
                        fieldProvider.decreaseField();
                      }
                    },
                    controller: _titleController),
                const SizedBox(
                  height: 20,
                ),
                ProductTextField(
                    inputType: TextInputType.url,
                    hint: "Image URL",
                    event: (value) {
                      if (value.isNotEmpty) {
                        if (count2 == 0) {
                          fieldProvider.increaseField();
                          count2++;
                        }
                      } else {
                        count2--;
                        fieldProvider.decreaseField();
                      }
                    },
                    controller: _imageLinkController),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(4)),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: ResponsiveSize.pageViewHeight(context) * 0.8,
                        minHeight: 50),
                    child: Scrollbar(
                      thickness: 10,
                      interactive: true,
                      controller: _scrollController,
                      thumbVisibility: true,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        controller: _scrollController,
                        child: TextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (count3 == 0) {
                                fieldProvider.increaseField();
                                count3++;
                              }
                            } else {
                              count3--;
                              fieldProvider.decreaseField();
                            }
                          },
                          autofocus: false,
                          maxLines: null,
                          cursorColor: CommonColors.buttonColor,
                          style: TextStyle(
                              fontFamily: "M500",
                              color: themeColor.onSecondary),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder
                                .none /*const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87))*/
                            ,
                            hintStyle: TextStyle(
                              color: themeColor.onSecondary,
                              fontFamily: "M400",
                              fontSize: (MediaQuery.of(context).size.width >=
                                      576
                                  ? (MediaQuery.of(context).size.width * 0.024)
                                  : (MediaQuery.of(context).size.width *
                                      0.037)),
                            ),
                            hintText: "Description",
                            fillColor: CommonColors.whiteC,
                            filled: true,
                          ),
                          controller: _descController,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ProductTextField(
                    hint: "Price in USD",
                    event: (value) {
                      if (value.isNotEmpty) {
                        if (count4 == 0) {
                          fieldProvider.increaseField();
                          count4++;
                        }
                      } else {
                        count4--;
                        fieldProvider.decreaseField();
                      }
                    },
                    inputType: TextInputType.number,
                    controller: _priceController),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ColoredButton(
                          text: product == null ? "Add" : "Update",
                          backColor: CommonColors.buttonColor,
                          fontFamily: "M500",
                          event: () {
                            if (_titleController.text.isNotEmpty &&
                                _descController.text.isNotEmpty &&
                                _imageLinkController.text.isNotEmpty &&
                                _priceController.text.toString().isNotEmpty &&
                                fieldProvider.category.isNotEmpty) {
                              try {
                                String title =
                                    _titleController.text.trim.toString();
                                String description =
                                    _descController.text.trim.toString();
                                String imageUrl =
                                    _imageLinkController.text.toString();
                                double price = double.parse(
                                    _priceController.text.toString());
                                String category = fieldProvider.category;
                                AllProducts send = AllProducts(
                                    id: product?.id!,
                                    title: title,
                                    description: description,
                                    image: imageUrl,
                                    price: price,
                                    category: category);
                                product == null
                                    ? addProduct(send, context)
                                    : updateProduct(send, context);
                              } on FormatException {
                                const snackBar =
                                    SnackBar(content: Text("Invalid Price"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              const snackBar = SnackBar(
                                  content:
                                      Text("PLEASE FILL ALL THE DETAILS!"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          fontSize: ResponsiveSize.getMediumLargeFont(context)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> addProduct(AllProducts allProducts, BuildContext context) async {
    AllProducts? response = await addProductAPi.addProductMethod(allProducts);
    if (context.mounted) {
      if (response != null) {
        print(response.id);
        const snackBar = SnackBar(content: Text("Product added Successfully "));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(content: Text("Unable to add "));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  updateProduct(AllProducts send, BuildContext context) async {
    AllProducts? response = await addProductAPi.updateProductMethod(send);
    if (context.mounted) {
      if (response != null) {
        print(response.id);
        const snackBar =
            SnackBar(content: Text("Product updated Successfully "));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(content: Text("Unable to update "));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
