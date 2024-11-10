import 'package:flutter/material.dart';

class ResponsiveSize {
  static double getWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 576 ? width * 0.03 : width * 0.05;
  }

  static double getAuthHPadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 576 ? width * 0.1 : width * 0.08;
  }

  static double getAuthVPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding.top;
  }

  static double getAuthTitleWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 576 ? width * 0.7 : width * 0.52;
  }

  static double getHeight(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return height >= 576 ? height * 0.03 : height * 0.05;
  }

  static int getMediumFont(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (width >= 576 ? width * 0.03 : width * 0.045).toInt();
  }

  static int getSmallFont(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (width >= 576 ? width * 0.027 : width * 0.037).toInt();
  }

  static int getNavBarFont(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (width >= 576 ? width * 0.02 : width * 0.035).toInt();
  }

  static int getTitleFont(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (width >= 576 ? width * 0.046 : width * 0.06).toInt();
  }

  static int getMediumLargeFont(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (width >= 576 ? width * 0.04 : width * 0.05).toInt();
  }

  static int getLargeFont(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (width >= 576 ? width * 0.07 : width * 0.09).toInt();
  }

  static double getScale(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 576 ? 1.3 : 2;
  }

  static double sizedBoxWidth(BuildContext context) {
    return 10;
  }

  static double sizedBoxHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 576 ? width * 0.07 : width * 0.065;
  }

  static double textFieldHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 576 ? width * 0.07 : width * 0.15;
  }

  static double buttonHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 576 ? width * 0.09 : width * 0.13;
  }

  static double sortButtonHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 576 ? width * 0.057 : width * 0.063;
  }

  static double sortButtonWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 576 ? width * 0.09 : width * 0.17;
  }

  static double categoriesHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 576 ? width * 0.2 : width * 0.22;
  }

  static double pageViewHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.27;
  }

  static double getShopPagePhotoHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height >= 1000 ? height * 0.35 : height * 0.3;
  }

  static double getCartContainerHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height >= 900 ? height * 0.75 : height * 0.6;
  }
}
