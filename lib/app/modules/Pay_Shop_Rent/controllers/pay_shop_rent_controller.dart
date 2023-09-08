import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../common/api_response.dart';
import '../../../common/function.dart';
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
    clearData();
  }

  //CIRCLE LIST (--DROPDOWN LIST--)
  Future<void> getCircleDetail() async {
    isPageLoading.value = true;
    APIResponse response = await PayShopRentProvider().CircleListData();
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data;
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
    selectedCircleId = "" ;
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
    selectedMarketId = "";
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data;
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
  // var  idData_monthlyRate = "";
  // var idData_lastDemand = "";
  var idData_paidUpto = "";
   var  idData_area = "";
  var idData_shopNo = "";
  var idData_Id = "";
  var  idData_userId = "" ;
 var  idData_lastPtmDate = "";
  var idData_Rate = 0.0;
  var idData_arrear = 0.0;
  var mDue = 0.0;
  var idData_lastDemand = "";
  var idData_lastpaymentAmt = 0.0;
  // DateTime idData_lastPtmDate = DateTime.now();
  var mPaidFromN = 0;
  var mPaidToN = 0;

  shopById(int shopId) async {
    await getShopDetailById(shopId);
  }
  //MARKET LIST BY CIRCLE (--DROPDOWN LIST--)
  Future<void> getShopDetailById(shopId) async {
    isPageLoading.value = true;
    APIResponse response = await PayShopRentProvider().ShopListDataById(shopId);
    if ( response.error == false) {
      var data = response.data;
      idData_sairatName = data['allottee'].toString();
      idData_presentOccupier = data['present_occupier'].toString();
      idData_contactNo = data['contact_no'].toString();
      idData_arrear = data['arrear'] == null ? 0.0 : double.parse(data['arrear']);
      idData_area = data['area'].toString();
      idData_circle = data['circle_name'].toString();
      idData_address = data['address'].toString();
      idData_market = data['market_name'].toString();
      idData_Rate =  data['rate'] == null ? 0.0 : double.parse(data['rate']);
      idData_lastpaymentAmt =  data['last_payment_amount'] == null ? 0.0 : double.parse(data['last_payment_amount']);
      // idData_lastPtmDate = data['last_payment_date'] == null ? DateTime.now() : new DateFormat('yyyy-MM-dd').parse(data['last_payment_date']);
      idData_lastPtmDate = data['last_payment_date'].toString();
      idData_paidUpto = data['payment_upto'] ?? '';
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




  var storeDateFrom = ''.obs;
  var storeDateUpto = ''.obs;
  var selectedMonth = ''.obs;
  var dateSelected = false.obs;
  RxInt databaseDate = 0.obs;


  Future<void> selectDate(BuildContext context, String buttonIdentifier) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      if (buttonIdentifier == 'Select Date 1') {
        storeDateFrom.value = formattedDate;
      } else if (buttonIdentifier == 'Select Date 2') {
        storeDateUpto.value = formattedDate;
      }
      dateSelected.value = true;
    }
  }

  int diffBetweenDate() {
    DateTime selectedDateFrom = DateTime.parse(storeDateFrom.value);
    DateTime selectedDateUpto = DateTime.parse(storeDateUpto.value);
    int takeDiff = (selectedDateUpto.year - selectedDateFrom.year) * 12 +
        (selectedDateUpto.month - selectedDateFrom.month);
    return takeDiff + 1;
  }



  Future<void> selectMonth(BuildContext context, String buttonIdentifier) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    selectedMonth.value = "";
    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      if (buttonIdentifier == 'Select DateUpto') {
        selectedMonth.value = formattedDate;
        dateSelected.value = true;
        update(); // Trigger a redraw of the widget.
      }
    }
  }

  int calculateMonthDifference() {
    if (dateSelected.value && idData_paidUpto.isNotEmpty && selectedMonth.value.isNotEmpty) {
      // DateTime currentDate = DateTime.parse(idData_paidUpto);
      String dateString = idData_paidUpto; // Your date string
      DateFormat format = DateFormat('dd/MM/yyyy');
      DateTime currentDate = format.parse(dateString);
      DateTime selectedDate = DateTime.parse(selectedMonth.value);

      int diffMonths = (selectedDate.year - currentDate.year) * 12 +
          (selectedDate.month - currentDate.month);
      return diffMonths;
    } else {
      return 0; // Handle the case when the dates are not valid or not selected.
    }}

    void calculateDifference(String date) {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = DateTime.parse(date);

    int checkMonths = ((currentDate.year - selectedDate.year) * 12 +
        (currentDate.month - selectedDate.month)) + 1;

    databaseDate.value = checkMonths;
  }

  void processDate(String date) {
    List<String> dateParts = date.split('/');
    String day = dateParts[0];
    String month = dateParts[1];
    String year = dateParts[2];

    DateTime dateObject = DateTime(int.parse(year), int.parse(month), int.parse(day));
    calculateDifference(dateObject.toString());
  }



  //*******************PAYMENT & PRINT
var payment_Amount = "";

  Future<void> ShopRentCollection() async{
      var payload = null;
      final inputFormat = DateFormat('dd/MM/yyyy');
      final parsedDate = inputFormat.parse(idData_paidUpto);
      final outputFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = outputFormat.format(parsedDate);
      if(idData_paidUpto != ''){
        payload={
          // 'paymentTo': idData_paidUpto.toString(),
          'paymentTo':formattedDate,
          'paymentFrom' : selectedMonth.value.toString(),
        };
      } else {
        payload = {
          'paymentTo':storeDateUpto.value.toString(),
          'paymentFrom' :storeDateFrom.value.toString(),
        };
      }
      isPageLoading(true);
      var result =  await PayShopRentProvider().ShopPaymentData(idData_Id, payload);
      if ( result.error == false) {
        var data = result.data;
       payment_Amount = data['paymentAmount'].toString();
        Get.dialog(
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.task_alt_rounded, size:85.0, color: Colors.green),
                SizedBox(height: 7,),
                Text(result.errorMessage,style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                color: Colors.green),),
                SizedBox(height: 5,),
                Text("Amount Paid  :  $payment_Amount"),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Close"),
              ),
            ],
          ),
        );
        Get.snackbar(
          '😁😁',
          result.errorMessage,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        isPageLoading.value = false;
      } else {
        Get.snackbar(
          '😫😫',
          result.errorMessage,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        isPageLoading.value = false;
      }
  }


var print_allottee = '';
var print_shop_no = '';
var print_address = '';
var print_rate = '';
var print_present_occupier = '';
var print_trade_license = '';
var print_contact_no = '';
var print_circle_name = '';
var print_market_name = '';
var print_construction_type = '';
var print_last_payment_date = '';
var print_last_payment_amount = '';
var print_payment_from = '';
var print_payment_upto = '';
var print_tcName = '';
var print_tcMobile = '';

Future<void> getShopReceipt() async{
    var ShopReceipts =  await PayShopRentProvider().getShopPrintReceipt(idData_Id);
    print_allottee = '';
    print_shop_no = '';
    print_address = '';
    print_rate = '';
    print_present_occupier = '';
    print_trade_license = '';
    print_contact_no = '';
    print_circle_name = '';
    print_market_name = '';
    print_construction_type = '';
    print_last_payment_date = '';
    print_last_payment_amount = '';
    print_payment_from = '';
    print_payment_upto = '';
    print_tcName = '';
    print_tcMobile = '';
       if (ShopReceipts.error == false) {
         var data = ShopReceipts.data;
         print_allottee = data[0]['allottee'].toString() ?? '';
         print_shop_no = data[0]['shop_no'].toString() ?? '';
         print_address = data[0]['address'].toString()?? '';
         print_rate = data[0]['rate'].toString() ?? '';
         print_present_occupier = data[0]['present_occupier'].toString() ?? '';
         print_trade_license = data[0]['trade_license'].toString() ?? '';
         print_contact_no = data[0]['contact_no'].toString() ?? '';
         print_circle_name = data[0]['circle_name'].toString() ?? '';
         print_market_name = data[0]['market_name'].toString() ?? '';
         print_construction_type = data[0]['construction_type'].toString() ?? '';
         print_last_payment_date = data[0]['last_payment_date'].toString() ?? '';
         print_last_payment_amount = data[0]['last_payment_amount'].toString() ?? '';
         print_payment_from = data[0]['payment_from'].toString() ?? '';
         print_payment_upto = data[0]['payment_upto'].toString() ?? '';
         print_tcName = data[0]['tcName'].toString() ?? '';
         print_tcMobile = data[0]['tcMobile'].toString() ?? '';
         Get.snackbar(
           '😫😫',
           ShopReceipts.errorMessage,
           backgroundColor: Colors.blue,
           colorText: Colors.white,
         );
      }else {
  Get.snackbar(
  '😫😫',
  ShopReceipts.errorMessage,
  backgroundColor: Colors.redAccent,
  colorText: Colors.white,
  );
  isPageLoading.value = false;
  }
  }


  getPrintString1() {
    var retStr = "";
    retStr += " ............................... \n" ;
    retStr += "         S H O P - R E N T \n" ;
    retStr += " ............................... \n" ;
    retStr += "SAIRAT HOLDER NAME : " + print_allottee + "\n" ;
    retStr += "SHOP ID : " + print_shop_no + "\n" ;
    retStr += "MARKET : " +  print_market_name + "\n" ;
    retStr += "CIRCLE : " +  print_circle_name + "\n" ;
    retStr += "CONTACT NO : " +  print_contact_no + "\n" ;
    retStr += "FROM MONTH : " +  print_payment_from + "\n" ;
    retStr += "TO MONTH : " +  print_payment_from + "\n" ;
    retStr += "LAST PMT ON : " +  print_last_payment_date + "\n" ;
    retStr += "PAYABLE AMOUNT : " +  print_last_payment_amount + "\n" ;

    retStr += " ............................... \n" ;
    return retStr;
  }
  getPrintString2() {
    var retStr = "";
    retStr = "TAX COLLECTOR NAME :" + print_tcName + "\n" ;
    retStr += "MOBILE NO :" + print_tcMobile + "\n" ;
    return retStr;
  }

  getPrintString3() {
    var retStr = "";
    retStr += " ............................... \n" ;
    retStr += "Note : This receipt is online \n generated receipt. ";
    retStr += "Keep this \n bill for future reference";
    return retStr;
  }



  void clearData() {
    storeDateFrom.value = "";
    storeDateUpto.value = "";
    selectedMonth.value = "";
    dateSelected.value = false;
  }
  @override
  void dispose() {
    super.dispose();
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
