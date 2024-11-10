import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  String paymentMode = "Visa";

  changePaymentMode(String mode) {
    paymentMode = mode;
    notifyListeners();
  }
}
