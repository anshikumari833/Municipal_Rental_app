import 'package:flutter/services.dart';

class PaymentService {
  //MethodChannel name  to communicate with Flutter
  static const platform = MethodChannel("com.amcakola.municipal_rental_tc_app/com.pinelabs.masterapp");
  // calls from Flutter
  static Future<void> sendIntentToPineLabs() async {
    try {
      //listens for a method "sendPaymentIntent"
      await platform.invokeMethod('sendPaymentIntent');
      print('Sent intent to Pine Labs');
    } on PlatformException catch (e) {
      print('Error sending intent: ${e.message}');
    }
  }
}
