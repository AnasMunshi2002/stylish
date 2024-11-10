import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/shared_pref/login/login_pref_manager.dart';
import '../../../view_models/product_provider/add_product_provider/add_provider.dart';
import '../../../view_models/theme_provider/colors/common.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../../screens/auth/login/login.dart';
import '../../screens/sell/add/add_product.dart';
import '../buttons/filled_button.dart';
import '../circle_profile/circle_profile.dart';
import '../responsive_size/responsive_size.dart';
import '../text/texts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    final fieldProvider = Provider.of<AddProductProvider>(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleProfile(event: () {}),
              const SizedBox(
                height: 7,
              ),
              TextWidget(
                color: themeColor.secondary,
                text: "Ms. ABC XYZ",
                fontFamily: "M600",
                fontSize: 17,
              ),
              TextWidget(
                color: themeColor.secondary,
                text: "abcxyz@gmail.com",
                fontFamily: "M300",
                fontSize: 12,
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: TextWidget(
                  color: themeColor.secondary,
                  text: "Account Settings",
                  fontFamily: "M400",
                  fontSize: 13,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.check_box_sharp),
                title: TextWidget(
                  color: themeColor.secondary,
                  text: "My Orders",
                  fontFamily: "M400",
                  fontSize: 13,
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.discount),
                title: TextWidget(
                  color: themeColor.secondary,
                  text: "Today's Special Deals",
                  fontFamily: "M400",
                  fontSize: 13,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.pets),
                title: TextWidget(
                  color: themeColor.secondary,
                  text: "Pet Stop",
                  fontFamily: "M400",
                  fontSize: 13,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.workspace_premium),
                title: TextWidget(
                  color: themeColor.secondary,
                  text: "Unlock Premium",
                  fontFamily: "M400",
                  fontSize: 13,
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  fieldProvider.initProgress();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProduct()));
                },
                leading: const Icon(Icons.local_shipping_outlined),
                title: TextWidget(
                  color: themeColor.secondary,
                  text: "Sell a Product",
                  fontFamily: "M400",
                  fontSize: 13,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.attach_money_rounded),
                title: TextWidget(
                  color: themeColor.secondary,
                  text: "My Transactions",
                  fontFamily: "M400",
                  fontSize: 13,
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  bool result = await showLogoutDialog(context, themeColor);
                  if (context.mounted) {
                    if (result) {
                      LoginManager.loginUpdate(false, "");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    }
                  }
                },
                leading: const Icon(
                  Icons.logout,
                  color: CommonColors.buttonColor,
                ),
                title: const TextWidget(
                  color: CommonColors.buttonColor,
                  text: "Log-out",
                  fontFamily: "M400",
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showLogoutDialog(
      BuildContext context, ColorScheme themeColor) async {
    return await showDialog(
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
                text: "Logout",
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
                          Navigator.pop(context, false);
                        },
                        fontSize: ResponsiveSize.getSmallFont(context)),
                    ColoredButton(
                        text: "Y e s",
                        backColor: CommonColors.navBarActive,
                        fontFamily: "M400",
                        event: () async {
                          Navigator.pop(context, true);
                          /*AddProductAPI addAPI = AddProductAPI();
                  AllProducts? result =
                  await addAPI.deleteProduct(product);
                  Navigator.pop(context);
                  if (result != null) {
                    print(result.id);
                    const snackBar = SnackBar(
                        content: Text("Product deleted Successfully "));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                  } else {
                    const snackBar =
                    SnackBar(content: Text("Unable to delete "));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                  }*/
                        },
                        fontSize: ResponsiveSize.getSmallFont(context))
                  ],
                )
              ],
            ));
  }
}
