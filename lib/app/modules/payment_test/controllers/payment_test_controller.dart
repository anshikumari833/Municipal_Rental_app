import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:convert';


class PaymentTestController extends GetxController {
  //TODO: Implement PaymentTestController

  static const MethodChannel _channel = MethodChannel('com.amcakola.municipal_rental_tc_app/com.pinelabs.masterapp');

  Future<void> openPinePOS() async {
    if (Platform.isAndroid) {

      try {
        final String responseDataJson = await _channel.invokeMethod('sendPaymentIntent');

        if (responseDataJson != null) {
          try {
            final Map<String, dynamic> response = json.decode(responseDataJson);
            handlePaymentResponse(response);
          } catch (e) {
            print('Error parsing JSON: $e');
          }
        } else {
          // Handle the case where the response is null or not a valid JSON string
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void handlePaymentResponse(Map<String, dynamic> response) {

  }



  // Future<void> openPinePOS() async {
  //   if (Platform.isAndroid) {
  //     final payload = {
  //       'REQUEST_DATA': {
  //         'Header': {
  //           'ApplicationId': '1001',
  //           'MethodId': '1004',
  //           'UserId': 'userId',
  //           'VersionNo': '1.0',
  //         },
  //       },
  //     };
  //
  //     final AndroidIntent intent = AndroidIntent(
  //       action: 'com.pinelabs.masterapp.HYBRID_REQUEST',
  //       package: 'com.pinelabs.masterapp',
  //       arguments: payload,
  //     );
  //     await androidIntentService.startActivity(intent);
  //
  //   }
  // }




  final responseMessage = RxString("");

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // listening the response of method calls
    const platform = MethodChannel("com.amcakola.municipal_rental_tc_app/com.pinelabs.masterapp");
    platform.setMethodCallHandler((call) async {
      if (call.method == 'handleResponse') {
        responseMessage.value = call.arguments;
      }
    });
  }



  // Future<void> sendIntentToPineLabs() async {
  //   // Define the payload JSON
  //   final payload = {
  //     // 'Detail': {
  //     //   'BillingRefNo': 'TX12345678',
  //     //   'PaymentAmount': 9900,
  //     //   'TransactionType': 4001,
  //     // },
  //     'Header': {
  //       'ApplicationId': '1004',
  //       'MethodId': '1004',
  //       'UserId': 'userId',
  //       'VersionNo': '1.0',
  //     },
  //   };
  //
  //   final intent = AndroidIntent(
  //     action: 'com.pinelabs.masterapp.HYBRID_REQUEST',
  //     package: 'com.pinelabs.masterapp',
  //     // componentName: 'com.pinelabs.masterapp/.MainActivity',
  //     arguments: <String, dynamic>{
  //       'REQUEST_DATA': payload.toString(),
  //     },
  //     flags: <int>[Flag.FLAG_ACTIVITY_CLEAR_TASK],
  //   );
  //
  //   // Start the intent and wait for a result
  //   await intent.launch();
  // }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
