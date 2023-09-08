import 'package:get/get.dart';
import '../../../common/api_response.dart';
import '../../../common/string.dart';

class PayTollRentProvider extends GetConnect {
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
  Future<APIResponse> MarketListData(selectedTollCircleId) async {
    String url = Strings.base_url + '/api/market/rental/list-circle-wise-market';
      final response = await post(url, {
        "circleId": selectedTollCircleId
      }, headers: Strings.headers);
      return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
    }

  // SEARCHED LIST
  Future<APIResponse> TollListData(selectedTollMarketId) async {
    String url = Strings.base_url + '/api/market/rental/list-toll-by-market-id';
      final response = await post(url, {
        "marketId": selectedTollMarketId,
      }, headers: Strings.headers);
      return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
    }

 //SEARCHED LIST BY ID DETAILS
  Future<APIResponse> TollListDataById(tollId) async {
    String url = Strings.base_url + '/api/market/rental/get-toll-detail-by-id';
      final response = await post(url, {
        "tollId": tollId,
      }, headers: Strings.headers);
    return APIResponse.fromJson({"data" : response.body, "error": response.status.hasError});
  }

}
