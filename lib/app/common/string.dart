import 'package:get_storage/get_storage.dart';

class Strings {
  static String loginApi_key = GetStorage().read('key');

 // static String base_url = 'http://192.168.0.21:8005';

   static String base_url = 'http://203.129.217.62:8005';

  static String api_key = "eff41ef6-d430-4887-aa55-9fcf46c72c99";

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + GetStorage().read('key').toString(),
    'API-KEY': "eff41ef6-d430-4887-aa55-9fcf46c72c99",
  };
}
