import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/api_response.dart';
import '../providers/pay_toll_rent_provider.dart';

class PayTollRentController extends GetxController {
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
    APIResponse response = await PayTollRentProvider().CircleListData();
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data;
      for (var circleDetail in ResponseList) {
        var id = circleDetail['id'].toString();
        var circleName = circleDetail['circle_name'].toString();
        CircleList.add({
          'id': id,
          'circle_name': circleName,
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

  var selectedTollCircleId;

  //MARKET LIST BY CIRCLE (--DROPDOWN LIST--)
  Future<void> getMarketDetail() async {
    isPageLoading.value = true;
    APIResponse response = await PayTollRentProvider().MarketListData(selectedTollCircleId);
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data;
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
  var selectedTollMarketId;
  var searchedTollListData = List<dynamic>.empty(growable: true).obs;
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

  //MARKET LIST BY CIRCLE (--DROPDOWN LIST--)
  Future<void> getSearchedShopDetail() async {
    isPageLoading.value = true;
    searchedTollListData.clear();
    APIResponse response = await PayTollRentProvider().TollListData(selectedTollMarketId);
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data;
      if (page == 1) {
        currentPage.value = ResponseList["current_page"];
        totalPages.value = ResponseList["last_page"];
      }
      List<dynamic> data = List<dynamic>.from(ResponseList["data"]);
      searchedTollListData.addAll(data);
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
  var idData_VendorName = "";
  var  idData_Address = "";
  var  idData_circle = "";
  var  idData_market = "";
  var   idData_Rate = "";
  var  idData_lastPaymentDate = "";
  var  idData_lastPymentAmt = "";
  var  idData_id = "";
  var  idData_TollType = "";
  var  idData_mobileNo = "";
  var  idData_TollNo  = "";


  TollById(int tollId) async {
    await getShopDetailById(tollId);
  }
  //MARKET LIST BY CIRCLE (--DROPDOWN LIST--)
  Future<void> getShopDetailById(tollId) async {
    isPageLoading.value = true;
    APIResponse response = await PayTollRentProvider().TollListDataById(tollId);
    if ( response.error == false) {
      var data = response.data;
      idData_VendorName = data['vendor_name'].toString();
      idData_Address = data['address'].toString();
      idData_circle = data['circle_name'].toString();
      idData_market = data['market_name'].toString();
      idData_Rate = data['rate'].toString();
      idData_TollNo = data['toll_no'].toString();
      idData_mobileNo = data['mobile'].toString();
      idData_lastPaymentDate= data['last_payment_date'].toString();
      idData_lastPymentAmt = data['last_payment_amount'].toString();
      idData_id = data['id'].toString();
      idData_TollType = data['toll_type'].toString();

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
