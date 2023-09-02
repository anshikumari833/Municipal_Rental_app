import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/api_response.dart';
import '../providers/pay_shop_rent_provider.dart';
import '../views/pay_shop_rent_DetailById.dart';

class PayShopRentController extends GetxController {
  var isPageLoading = false.obs;
  RxList<Map<String, dynamic>> CircleList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> MarketListByCircle = <Map<String, dynamic>>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCircleDetail();
  }

  //CIRCLE LIST (--DROPDOWN LIST--)
  Future<void> getCircleDetail() async {
    isPageLoading.value = true;
    APIResponse response = await PayShopRentProvider().CircleListData();
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data['data'];
      List<Map<String, dynamic>> newCircleList = [];

      for (var circleDetail in ResponseList) {
        var id = circleDetail['id'].toString();
        var circleName = circleDetail['circle_name'].toString();
        newCircleList.add({
          'id': id,
          'circle_name': circleName,
        });
      }
      CircleList.assignAll(newCircleList);
      isPageLoading.value = false;
    } else {
      Get.snackbar(
        '😫😫',
        response.errorMessage,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      isPageLoading.value = false;
    }
  }

var selectedCircleId;
  //MARKET LIST BY CIRCLE (--DROPDOWN LIST--)
  Future<void> getMarketDetail() async {
    isPageLoading.value = true;
    MarketListByCircle.clear();
    APIResponse response = await PayShopRentProvider().MarketListData(selectedCircleId);
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data['data'];
      for (var marketDetail in ResponseList) {
        var id = marketDetail['id'];
        var marketName = marketDetail['market_name'];
        MarketListByCircle.add({
          'id': id,
          'market_name': marketName,
        });
      }
      isPageLoading.value = false;
    } else {
      Get.snackbar(
        '😫😫',
        response.errorMessage,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      isPageLoading.value = false;
    }
  }

  var circle = "".obs;
  var market = "".obs;
  var selectedMarketId;
  var searchedShopListData = List<dynamic>.empty(growable: true).obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var totalPages = 1.obs;
  int page = 1;
  int perPage = 10;

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      getSearchedShopDetail();
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      getSearchedShopDetail();
    }
  }

  //SEARCH LIST DETAIL OF  CIRCLE AND MARKET
  Future<void> getSearchedShopDetail() async {
    isPageLoading.value = true;
    searchedShopListData.clear();
    APIResponse response = await PayShopRentProvider().ShopListData(selectedMarketId);
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data['data'];
      if (page == 1) {
        currentPage.value = ResponseList["current_page"];
        totalPages.value = ResponseList["last_page"];
        searchedShopListData.clear();
      }
      List<dynamic> data = List<dynamic>.from(ResponseList["data"]);
      searchedShopListData.addAll(data);
      isPageLoading.value = false;
    } else {
      Get.snackbar(
        '😫😫',
        response.errorMessage,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      isPageLoading.value = false;
    }

  }



  //DETAIL LIST BY ID
  var ShopListDataById = List<dynamic>.empty(growable: true).obs;
  var idData_sairatName = "";
  var  idData_contactNo = "";
  var  idData_presentOccupier = "";
  var  idData_circle = "";
  var  idData_address  = "";
  var  idData_market = "";
  var   idData_monthlyRent = "";
  var  idData_lastDemand = "";
  var idData_paidUpto = "";
  var  idData_lastPtmOn = "";
  var idData_shopNo = "";
  var idData_Id = "";
  var  idData_userId = "";

  shopById(int shopId) async {
    await getShopDetailById(shopId);
  }
  //MARKET LIST BY CIRCLE (--DROPDOWN LIST--)
  Future<void> getShopDetailById(shopId) async {
    isPageLoading.value = true;
    APIResponse response = await PayShopRentProvider().ShopListDataById(shopId);
    if ( response.error == false) {
      var data = response.data['data'];
      idData_sairatName = data['allottee'].toString();
      idData_presentOccupier = data['present_occupier'].toString();
      idData_contactNo = data['contact_no'].toString();
      idData_circle = data['circle_name'].toString();
      idData_address = data['address'].toString();
      idData_market = data['market_name'].toString();
      idData_monthlyRent = data['rate'].toString();
      idData_lastDemand = data['last_payment_amount'].toString();
      idData_paidUpto = data['payment_upto'].toString();
      idData_lastPtmOn = data['last_payment_date'].toString();
      idData_shopNo = data['shop_no'].toString();
      idData_Id = data['id'].toString();
      idData_userId = data['user_id'].toString();
      isPageLoading.value = false;
    } else {
      Get.snackbar(
        '😫😫',
        response.errorMessage,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      isPageLoading.value = false;
    }
  }


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
