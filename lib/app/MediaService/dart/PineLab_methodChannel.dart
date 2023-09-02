import 'package:flutter/services.dart';

Future<void> bindToPlutusService() async {
  const platform = MethodChannel("com.amcakola.municipal_rental_tc_app/");
  try {
    await platform.invokeMethod('bindToPlutusService');
    print('Bound to Plutus Smart Service');
  } on PlatformException catch (e) {
    print('Error binding to Plutus Smart Service: ${e.message}');
  }
}