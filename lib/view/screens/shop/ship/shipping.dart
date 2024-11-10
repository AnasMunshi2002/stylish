import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/payment_provider/payment_provider.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/assets/icons/app_icons.dart';
import '../../../widgets/responsive_size/responsive_size.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<num> tweenSpread;
  late Animation<num> tweenBlur;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 50));
    tweenSpread = Tween(begin: 2, end: 0.0).animate(_animationController);
    tweenBlur = Tween(begin: 3, end: 0.0).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
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
              )),
        ),
        backgroundColor: themeColor.primary,
        title: Text(
          "Checkout",
          style: TextStyle(
            fontFamily: "M600",
            fontSize: ResponsiveSize.getMediumLargeFont(context).toDouble(),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order",
                    style: TextStyle(
                        fontFamily: "M500",
                        fontSize: ResponsiveSize.getMediumLargeFont(context)
                            .toDouble(),
                        color: CommonColors.greyC),
                  ),
                  Text(
                    "₹ 7,000",
                    style: TextStyle(
                        fontFamily: "M500",
                        fontSize: ResponsiveSize.getMediumLargeFont(context)
                            .toDouble(),
                        color: CommonColors.greyC),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping",
                    style: TextStyle(
                        fontFamily: "M500",
                        fontSize: ResponsiveSize.getMediumLargeFont(context)
                            .toDouble(),
                        color: CommonColors.greyC),
                  ),
                  Text(
                    "₹30",
                    style: TextStyle(
                        fontFamily: "M500",
                        fontSize: ResponsiveSize.getMediumLargeFont(context)
                            .toDouble(),
                        color: CommonColors.greyC),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontFamily: "M500",
                        fontSize: ResponsiveSize.getMediumLargeFont(context)
                            .toDouble(),
                        color: CommonColors.greyC),
                  ),
                  Text(
                    "₹ 7,030",
                    style: TextStyle(
                        fontFamily: "M500",
                        fontSize: ResponsiveSize.getMediumLargeFont(context)
                            .toDouble(),
                        color: CommonColors.greyC),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(
                thickness: 1.5,
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                "Payment",
                style: TextStyle(
                    fontFamily: "M500",
                    fontSize:
                        ResponsiveSize.getMediumLargeFont(context).toDouble(),
                    color: themeColor.secondary),
              ),
              const SizedBox(
                height: 10,
              ),
              FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(themeColor.primaryContainer),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 17, vertical: 20)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              width: MediaQuery.of(context).size.width >= 600
                                  ? 2.5
                                  : 1.5,
                              color: context
                                          .watch<PaymentProvider>()
                                          .paymentMode ==
                                      "Visa"
                                  ? CommonColors.buttonColor
                                  : Colors.transparent)))),
                  onPressed: () {
                    context.read<PaymentProvider>().changePaymentMode("Visa");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppIcons.visa,
                        scale: ResponsiveSize.getScale(context),
                      ),
                      Text(
                        "*********2109",
                        style: TextStyle(
                            fontFamily: "M500",
                            fontSize: ResponsiveSize.getMediumFont(context)
                                .toDouble(),
                            color: CommonColors.greyC),
                      )
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(themeColor.primaryContainer),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 17, vertical: 20)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              width: MediaQuery.of(context).size.width >= 600
                                  ? 2.5
                                  : 1.5,
                              color: context
                                          .watch<PaymentProvider>()
                                          .paymentMode ==
                                      "Paypal"
                                  ? CommonColors.buttonColor
                                  : Colors.transparent)))),
                  onPressed: () {
                    context.read<PaymentProvider>().changePaymentMode("Paypal");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppIcons.payPal,
                        scale: ResponsiveSize.getScale(context),
                      ),
                      Text(
                        "*********2109",
                        style: TextStyle(
                            fontFamily: "M500",
                            fontSize: ResponsiveSize.getMediumFont(context)
                                .toDouble(),
                            color: CommonColors.greyC),
                      )
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(themeColor.primaryContainer),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 17, vertical: 20)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              width: MediaQuery.of(context).size.width >= 600
                                  ? 2.5
                                  : 1.5,
                              color: context
                                          .watch<PaymentProvider>()
                                          .paymentMode ==
                                      "Maestro"
                                  ? CommonColors.buttonColor
                                  : Colors.transparent)))),
                  onPressed: () {
                    context
                        .read<PaymentProvider>()
                        .changePaymentMode("Maestro");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppIcons.maestro,
                        scale: ResponsiveSize.getScale(context),
                      ),
                      Text(
                        "*********2109",
                        style: TextStyle(
                            fontFamily: "M500",
                            fontSize: ResponsiveSize.getMediumFont(context)
                                .toDouble(),
                            color: CommonColors.greyC),
                      )
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(themeColor.primaryContainer),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 17, vertical: 20)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              width: MediaQuery.of(context).size.width >= 600
                                  ? 2.5
                                  : 1.5,
                              color: context
                                          .watch<PaymentProvider>()
                                          .paymentMode ==
                                      "ApplePay"
                                  ? CommonColors.buttonColor
                                  : Colors.transparent)))),
                  onPressed: () {
                    context
                        .read<PaymentProvider>()
                        .changePaymentMode("ApplePay");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppIcons.applePay,
                        scale: ResponsiveSize.getScale(context),
                      ),
                      Text(
                        "*********2109",
                        style: TextStyle(
                            fontFamily: "M500",
                            fontSize: ResponsiveSize.getMediumFont(context)
                                .toDouble(),
                            color: CommonColors.greyC),
                      )
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTapDown: (details) {
                          _onTap(details, context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: themeColor.tertiary,
                                  spreadRadius: double.parse(
                                      tweenSpread.value.toString()),
                                  blurRadius:
                                      double.parse(tweenBlur.value.toString())),
                              BoxShadow(
                                  color: themeColor.tertiary,
                                  spreadRadius: double.parse(
                                      tweenSpread.value.toString()),
                                  blurRadius:
                                      double.parse(tweenBlur.value.toString()))
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: CommonColors.buttonColor,
                          ),
                          child: const Text(
                            softWrap: true,
                            "Continue",
                            style: TextStyle(
                                fontFamily: "M700",
                                fontSize: 22,
                                color: CommonColors.whiteC),
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showSucessPayment(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: CommonColors.whiteC,
        child: Container(
          width: MediaQuery.of(context).size.width >= 600
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                AppIcons.successPay,
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Payment done successfully.",
                      style: TextStyle(
                          color: CommonColors.blackC,
                          fontFamily: "M600",
                          fontSize:
                              ResponsiveSize.getMediumFont(context).toDouble()),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(TapDownDetails details, BuildContext context) async {
    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _animationController.reverse();
    if (context.mounted) {
      _showSucessPayment(context);
    }
  }

// void _onTapUp(TapUpDetails details) asyncs{
//   _animationController.reverse();
// }
}
