import 'package:get/get.dart';

import '../../../common/api_response.dart';
import '../../../common/string.dart';

class LoginScreenProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<APIResponse> userLogin(Map data) async {
    // var loginApiKey = Strings.loginApi_key;
    String url = Strings.base_url + '/api/login';

    try {
      final response = await post('$url', data  ).timeout(Duration(seconds: 30));

      if (response.status.hasError) {
        return APIResponse(
            data: null, error: true, errorMessage: response.statusText!);

      } else {
        var mData = response.body['data']['token'];
        var userName = response.body['data']['userDetails']['name'];

        // role checking
        // var checkTc = ['TAX COLLECTOR'];
        // var checkUtc = ['ULB TAX COLLECTOR'];
        // final isTc = (response.body['data']['userDetails']['role']).isNotEmpty && (response.body['data']['userDetails']['role']).any((role) => checkTc.contains(role));
        // final isUtc = (response.body['data']['userDetails']['role']).isNotEmpty && (response.body['data']['userDetails']['role']).any((role) => checkUtc.contains(role));
        final isTc = (response.body['data']['userDetails']['role']).isNotEmpty && (response.body['data']['userDetails']['role']).any((role) => role.toLowerCase() == 'tax collector');
        final isUtc = (response.body['data']['userDetails']['role']).isNotEmpty && (response.body['data']['userDetails']['role']).any((role) => role.toLowerCase() == 'seniour lipik');
        final isJe = (response.body['data']['userDetails']['role']).isNotEmpty && (response.body['data']['userDetails']['role']).any((role) => role.toLowerCase() == 'junior engineer');
        final isTd = (response.body['data']['userDetails']['role']).isNotEmpty && (response.body['data']['userDetails']['role']).any((role) => role.toLowerCase() == 'tax daroga');
        return APIResponse(
            data: [mData, isTc, isUtc, userName,isJe,isTd], error: false, errorMessage: response.statusText!);
      }
    } catch (error) {
      return APIResponse(
          data: null, error: true, errorMessage: error.toString());
    }
  }

}

