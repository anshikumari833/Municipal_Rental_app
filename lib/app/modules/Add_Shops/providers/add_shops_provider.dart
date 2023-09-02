import 'package:get/get.dart';
import '../../../common/api_response.dart';
import '../../../common/string.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddShopsProvider extends GetConnect {
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
    try {
      final response = await post(url, {
        "circleId": selectedCircleId
      }, headers: Strings.headers);
      if (response.status.hasError) {
        return APIResponse(
            data: null, error: true, errorMessage: response.statusText!);
      } else {
        return  APIResponse(
            data: response.body,
            error: false,
            errorMessage: response.statusText!);
      }
    } catch (exception) {
      return APIResponse(
          data: null, error: true, errorMessage: exception.toString());
    }
  }

  //CONSTRUCTION LIST (--DROPDOWN LIST--)
  Future<APIResponse> ConstructionListData() async {
    String url = Strings.base_url + '/api/market/rental/list-construction';
    try {
      final response = await post(url, {}, headers:
      Strings.headers);
      if (response.status.hasError) {
        return APIResponse(
            data: null, error: true, errorMessage: response.statusText!);
      } else {
        return  APIResponse(
            data: response.body,
            error: false,
            errorMessage: response.statusText!);
      }
    } catch (exception) {
      return APIResponse(
          data: null, error: true, errorMessage: exception.toString());
    }
  }


  //SUBMIT APPLICATION
  // Future<APIResponse> SubmitShopApplication(Map data) async {
  //   String url = Strings.base_url + '/api/market/crud/shop/store';
  //   try {
  //     final response = await post(url, {
  //       "circleId":  data["circleId"],
  //       "marketId": data["marketId"],
  //       "allottee": data["allottee"],
  //       "address": data["address"],
  //       "rate": data["rate"],
  //       "arrear": data["arrear"],
  //       "allottedLength": data["allottedLength"],
  //       "allottedBreadth":  data["allottedBreadth"],
  //       "allottedHeight": data["allottedHeight"],
  //       "area": data["area"],
  //       "presentLength": data["presentLength"],
  //       "presentBreadth": data["presentBreadth"],
  //       "presentHeight": data["presentHeight"],
  //       "noOfFloors": data["noOfFloors"],
  //       "presentOccupier":  data["presentOccupier"],
  //       "tradeLicense": data["tradeLicense"],
  //       "construction": data["construction"],
  //       "electricity": data["electricity"],
  //       "water": data["water"],
  //       "contactNo": data["contactNo"],
  //       "longitude":  data["longitude"],
  //       "latitude": data["latitude"],
  //       "photo1Path": data["photo1Path"],
  //       "photo2Path": data["photo2Path"],
  //       "remarks": data["remarks"],
  //     }, headers: Strings.headers );
  //     if (response.status.hasError) {
  //       return APIResponse(
  //           data: null, error: true, errorMessage: response.statusText!);
  //     } else {
  //       return APIResponse(
  //           data: response.body['data'],
  //           error: false,
  //           errorMessage: response.statusText!);
  //     }
  //   } catch (exception) {
  //     return APIResponse(
  //         data: null, error: true, errorMessage: exception.toString());
  //   }
  // }

  Future<APIResponse> SubmitShopApplication(Map data) async {
    String url = Strings.base_url + '/api/market/crud/shop/store';

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(Strings.headers);
      request.fields['circleId'] = data['circleId'];
      request.fields['marketId'] = data['marketId'];
      request.fields['allottee'] = data['allottee'];
      request.fields['contactNo'] = data['contactNo'];
      request.fields['address'] = data['address'];
      request.fields['rate'] = data['rate'];
      request.fields['arrear'] = data['arrear'];
      request.fields['allottedLength'] = data['allottedLength'];
      request.fields['allottedBreadth'] = data['allottedBreadth'];
      request.fields['allottedHeight'] = data['allottedHeight'];
      request.fields['area'] = data['area'];
      request.fields['presentLength'] = data['presentLength'];
      request.fields['presentBreadth'] = data['presentBreadth'];
      request.fields['presentHeight'] = data['presentHeight'];
      request.fields['noOfFloors'] = data['noOfFloors'];
      request.fields['presentOccupier'] = data['presentOccupier'];
      request.fields['tradeLicense'] = data['tradeLicense'];
      request.fields['construction'] = data['construction'];
      request.fields['electricity'] = data['electricity'];
      request.fields['water'] = data['water'];
      request.fields['longitude'] = data['longitude'];
      request.fields['latitude'] = data['latitude'];
      request.fields['remarks'] = data['remarks'];
      // Add your image files
      final file1 = http.MultipartFile.fromBytes(
        'photo1Path',
        (data['photo1Path'] as File).readAsBytesSync(),
        filename: 'image1.png',
      );
      final file2 = http.MultipartFile.fromBytes(
        'photo2Path',
        (data['photo2Path'] as File).readAsBytesSync(),
        filename: 'image2.png',
      );
      request.files.add(file1);
      request.files.add(file2);

      final response = await request.send();
      final responseStream = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // final responseData = json.decode(responseStream);
        return APIResponse(
          data: response,
          error: false,
          errorMessage: '',
        );
      } else {
        return APIResponse(
          data: response,
          error: true,
          errorMessage: '',
        );
      }
  }
}
