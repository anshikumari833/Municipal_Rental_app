import 'dart:convert';

import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../common/api_response.dart';
import '../../../common/string.dart';

class AddTollsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  //CIRCLE LIST (--DROPDOWN LIST--)
  Future<APIResponse> CircleListData() async {
    String url = Strings.base_url + '/api/market/rental/list-ulb-wise-circle';
      final response = await post(url, {}, headers: Strings.headers);
      return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
    }


  //MARKET LIST BY CIRCLE (--DROPDOWN LIST--)
  Future<APIResponse> MarketListData(selectedCircleId) async {
    String url = Strings.base_url + '/api/market/rental/list-circle-wise-market';
      final response = await post(url, {
        "circleId": selectedCircleId
      }, headers: Strings.headers);
    return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
  }

  //RATE LIST (--DROPDOWN LIST--)
  Future<APIResponse> RateListData() async {
    String url = Strings.base_url + '/api/market/rental/get-toll-price-list';
      final response = await post(url, {}, headers: Strings.headers);
    return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
  }

  //SUBMIT APPLICATION
  Future<APIResponse> SubmitTollApplication(Map data) async {
    String url = Strings.base_url + '/api/market/crud/toll/insert';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(Strings.headers);
    request.fields['circleId'] = data['circle'];
    request.fields['marketId'] = data['market'];
    request.fields['vendorName'] = data['vendorName'];
    request.fields['contactNo'] = data['MobileNo'];
    request.fields['address'] = data['Landmark'];
    request.fields['rate'] = data['rate'];
    request.fields['longitude'] = data['longitude'];
    request.fields['latitude'] = data['latitude'];
    request.fields['remarks'] = data['remarks'];
    // Add your image files
    final file1 = http.MultipartFile.fromBytes(
      'photograph1',
      (data['photograph1'] as File).readAsBytesSync(),
      filename: 'image1.png',
    );
    final file2 = http.MultipartFile.fromBytes(
      'photograph2',
      (data['photograph2'] as File).readAsBytesSync(),
      filename: 'image2.png',
    );
    request.files.add(file1);
    request.files.add(file2);

    final response = await request.send();
    final responseStream = await response.stream.bytesToString();
    return APIResponse.fromJson({"data": responseStream, "error": false});
  }
}
