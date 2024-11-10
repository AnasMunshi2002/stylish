import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";

import "../../../../view_models/navigation_provider/navigation_provider.dart";
import "../../../../view_models/theme_provider/colors/common.dart";
import "../../../../view_models/theme_provider/theme.dart";
import "../../../widgets/assets/icons/app_icons.dart";
import "../../../widgets/drawer/drawer.dart";
import "../../../widgets/responsive_size/responsive_size.dart";
import "../../cart/all_cart/all_cart.dart";
import "../../settings/settings.dart";
import "../../shop/shop_page/shop_page.dart";
import "../profile/profile.dart";
import "../search/search_page.dart";
import "../trending/trending.dart";
import "home_body.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Widget> _pages = [
  const MyHomeScreen(),
  const TrendingProducts(),
  const ShopPage(),
  const SearchPage(),
  const Settings()
];

class _HomePageState extends State<HomePage> {
  late final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor =
        Provider.of<ThemeProvider>(context).currentTheme.colorScheme;
    final navigation = Provider.of<NavigationProvider>(context);
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: themeColor.primary,
        appBar: navigation.currentIndex == 2
            ? AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: themeColor.brightness,
                    statusBarIconBrightness:
                        themeColor.brightness == Brightness.dark
                            ? Brightness.light
                            : Brightness.dark),
                backgroundColor: themeColor.primary,
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllCart()));
                      },
                      child: CircleAvatar(
                          radius: (MediaQuery.of(context).size.width >= 576
                              ? 30
                              : 20),
                          backgroundColor: themeColor.primaryContainer,
                          child: Image.asset(AppIcons.cart,
                              scale: ResponsiveSize.getScale(context)))),
                  const SizedBox(width: 10)
                ],
                leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: IconButton(
                        style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(CircleBorder())),
                        onPressed: () {
                          navigation.changePage(0);
                        },
                        icon: Image.asset(
                            color: themeColor.secondary,
                            AppIcons.backIcon,
                            scale: ResponsiveSize.getScale(context)))))
            : AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: themeColor.brightness,
                    statusBarIconBrightness:
                        themeColor.brightness == Brightness.dark
                            ? Brightness.light
                            : Brightness.dark),
                backgroundColor: themeColor.primary,
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()));
                      },
                      child: CircleAvatar(
                          radius: (MediaQuery.of(context).size.width >= 576
                              ? 30
                              : 20),
                          child: Image.asset(AppIcons.profilePhoto,
                              scale: ResponsiveSize.getScale(context)))),
                  const SizedBox(width: 10)
                ],
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(AppIcons.titleIcon,
                      scale: ResponsiveSize.getScale(context)),
                  const SizedBox(width: 10),
                  Text("Stylish",
                      style: TextStyle(
                          fontFamily: "L700",
                          color: themeColor.secondaryFixed,
                          fontSize: (MediaQuery.of(context).size.width >= 576
                              ? (MediaQuery.of(context).size.width * 0.043)
                              : (MediaQuery.of(context).size.width * 0.05))))
                ]),
                leading: CircleAvatar(
                    backgroundColor: MediaQuery.of(context).size.width >= 576
                        ? themeColor.primary
                        : Colors.transparent,
                    child: IconButton(
                        style: ButtonStyle(
                            shape: const WidgetStatePropertyAll(CircleBorder()),
                            backgroundColor:
                                WidgetStatePropertyAll(themeColor.primary)),
                        onPressed: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        icon: Image.asset(
                            color: themeColor.secondary,
                            AppIcons.drawerIcon,
                            scale: ResponsiveSize.getScale(context))))),
        drawer: const DrawerWidget(),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 30,
            type: BottomNavigationBarType.fixed,
            backgroundColor: themeColor.primaryFixed,
            onTap: (index) {
              navigation.changePage(index);
            },
            selectedLabelStyle: TextStyle(
                fontFamily: "M500",
                fontSize: ResponsiveSize.getNavBarFont(context).toDouble()),
            unselectedLabelStyle: TextStyle(
                fontFamily: "M500",
                fontSize: ResponsiveSize.getNavBarFont(context).toDouble()),
            currentIndex: navigation.currentIndex,
            selectedItemColor: CommonColors.navBarActive,
            unselectedItemColor: themeColor.secondary,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(AppIcons.homeIcon,
                      color: themeColor.secondary,
                      scale: ResponsiveSize.getScale(context)),
                  label: "Home",
                  activeIcon: Image.asset(AppIcons.homeIcon,
                      scale: ResponsiveSize.getScale(context),
                      color: CommonColors.navBarActive)),
              BottomNavigationBarItem(
                  icon: Image.asset(
                      color: themeColor.secondary,
                      AppIcons.wishlist,
                      scale: ResponsiveSize.getScale(context)),
                  label: "Wishlist",
                  activeIcon: Image.asset(AppIcons.wishlist,
                      scale: ResponsiveSize.getScale(context),
                      color: CommonColors.navBarActive)),
              BottomNavigationBarItem(
                  icon: Image.asset(
                      color: themeColor.secondary,
                      AppIcons.cartNav,
                      scale: ResponsiveSize.getScale(context)),
                  label: "",
                  activeIcon: Image.asset(AppIcons.cartNav,
                      scale: ResponsiveSize.getScale(context),
                      color: CommonColors.navBarActive)),
              BottomNavigationBarItem(
                  icon: Image.asset(
                      color: themeColor.secondary,
                      AppIcons.search,
                      scale: ResponsiveSize.getScale(context)),
                  label: "Search",
                  activeIcon: Image.asset(AppIcons.search,
                      scale: ResponsiveSize.getScale(context),
                      color: CommonColors.navBarActive)),
              BottomNavigationBarItem(
                  icon: Image.asset(
                      color: themeColor.secondary,
                      AppIcons.settings,
                      scale: ResponsiveSize.getScale(context)),
                  label: "Setting",
                  activeIcon: Image.asset(AppIcons.settings,
                      scale: ResponsiveSize.getScale(context),
                      color: CommonColors.navBarActive))
            ]),
        body: _pages[navigation.currentIndex]);
  }
}
