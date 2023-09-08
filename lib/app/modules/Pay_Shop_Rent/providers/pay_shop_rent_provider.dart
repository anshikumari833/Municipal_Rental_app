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

  // SEARCHED LIST
  Future<APIResponse> ShopListData(selectedMarketId) async {
    String url = Strings.base_url + '/api/market/rental/list-shop-by-market-id';
      final response = await post(url, {
        "marketId": selectedMarketId,
      }, headers: Strings.headers);
      return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
    }

  //SEARCHED LIST BY ID DETAILS
  Future<APIResponse> ShopListDataById(shopId) async {
    String url = Strings.base_url + '/api/market/rental/get-shop-detail-by-id';
      final response = await post(url, {
        "shopId": shopId,
      }, headers: Strings.headers);
    return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
  }

  //SHOP PAYMENT
  Future<APIResponse> ShopPaymentData(idData_Id, Map data) async {
    String url = Strings.base_url + '/api/market/shop-payments';
    final response = await post(url, {
      "shopId": idData_Id,
      "paymentTo":data["paymentTo"],
      "paymentFrom":data["paymentFrom"],
    }, headers: Strings.headers);
    return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
  }

  //SHOP PRINT RECEIPT
  Future<APIResponse> getShopPrintReceipt(idData_Id) async {
    String url = Strings.base_url + '/api/market/rental/get-shop-payment-reciept';
    final response = await post(url, {
      "shopId": idData_Id,
    }, headers: Strings.headers);
    return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
  }


}
