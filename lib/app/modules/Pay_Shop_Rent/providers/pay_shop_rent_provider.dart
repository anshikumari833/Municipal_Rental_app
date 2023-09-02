import 'package:get/get.dart';
import '../../../common/api_response.dart';
import '../../../common/string.dart';

class PayShopRentProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  //CIRCLE LIST (--DROPDOWN LIST--)
  Future<APIResponse> CircleListData() async {
    String url = Strings.base_url + '/api/market/rental/list-ulb-wise-circle';
    try {
      final response = await post(url, {}, headers: Strings.headers);
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
  // SEARCHED LIST
  Future<APIResponse> ShopListData(selectedMarketId) async {
    String url = Strings.base_url + '/api/market/rental/list-shop-by-market-id';
    try {
      final response = await post(url, {
        "marketId": selectedMarketId,
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
  //SEARCHED LIST BY ID DETAILS
  Future<APIResponse> ShopListDataById(shopId) async {
    String url = Strings.base_url + '/api/market/rental/get-shop-detail-by-id';
    try {
      final response = await post(url, {
        "shopId": shopId,
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


}
