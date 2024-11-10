import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/shared_pref/login/login_pref_manager.dart';
import 'services/shared_pref/on_boarding_screen/on_boarding_screen.dart';
import 'services/shared_pref/theme_store/theme_pref.dart';
import 'view/screens/splash/splash.dart';
import 'view_models/login/login_provider.dart';
import 'view_models/navigation_provider/navigation_provider.dart';
import 'view_models/page_view_provider/page_view_provider.dart';
import 'view_models/payment_provider/payment_provider.dart';
import 'view_models/product_provider/add_product_provider/add_provider.dart';
import 'view_models/product_provider/cart_provider/cart_provider.dart';
import 'view_models/product_provider/cloth_size_provider.dart';
import 'view_models/product_provider/product_provider.dart';
import 'view_models/sort_provider/sort_provider.dart';
import 'view_models/theme_provider/theme.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemePrefManager.initPref();
  await LoginManager.initPref();
  await OnBoardingScreen.initBoardingPref();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => PageViewProvider()),
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => PaymentProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => SortProvider()),
    ChangeNotifierProvider(create: (_) => AddProductProvider()),
    ChangeNotifierProvider(create: (_) => ClothSizeProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: context.watch<ThemeProvider>().currentTheme,
        debugShowCheckedModeBanner: false,
        title: "Stylish App",
        home: const SplashScreen());
  }
}
