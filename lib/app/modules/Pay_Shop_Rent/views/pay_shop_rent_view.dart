import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:municipal_rental_tc_app/app/modules/Pay_Shop_Rent/views/pay_shop_rent_DetailById.dart';
import '../../../Widgets/Common_Dropdown.dart';
import '../../../common/All_Common_Function.dart';
import '../controllers/pay_shop_rent_controller.dart';

class PayShopRentView extends GetView<PayShopRentController> {
  const PayShopRentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        title:  Text('Shop Rental Pay',style: GoogleFonts.publicSans(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 6, bottom: 4, left: 6, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(CupertinoIcons.search_circle),
                        Text(
                          '  Search Shop',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(CupertinoIcons.info_circle_fill , size: 18,color: Colors.black),
                      Text("  Select Circle to get Market list ",
                        style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                  //CIRLCLE
                  Obx(() => CustomDropdownFormField(
                    headingText: 'Circle',
                    items: controller.isPageLoading.value
                        ? [
                      DropdownMenuItem(
                        value: null,
                        child:  Center(child:SpinKitThreeBounce(
                          color: Colors.blue,
                          size: 20.0,
                        ),),
                      ),
                    ]
                        : controller.CircleList.map<DropdownMenuItem<String>>((circle) {
                      return DropdownMenuItem<String>(
                        value: circle['id'].toString(),
                        child: Text(circle['circle_name'].toString()),
                      );
                    }).toList(),
                    hintText: 'Select an option',
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    onChanged: (circleValue) {
                      controller.circle.value = circleValue.toString();
                      controller.selectedCircleId = circleValue.toString();
                      controller.getMarketDetail();
                    },
                  ),),
                  //MARKET
                  Row(
                    children: [
                      Icon(CupertinoIcons.info_circle_fill , size: 18,color: Colors.black),
                      Text("  Select Market to get Shop list ",
                        style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                  Obx(() => CustomDropdownFormField(
                    headingText: 'Market',
                    items: controller.isPageLoading.value
                        ? [
                      DropdownMenuItem(
                        value: null,
                        child:  Center(child:SpinKitThreeBounce(
                          color: Colors.blue,
                          size: 20.0,
                        ),),
                      ),
                    ]
                        : controller.MarketListByCircle.map<DropdownMenuItem<String>>((circle) {
                      return DropdownMenuItem<String>(
                        value: circle['id'].toString(),
                        child: Text(circle['market_name'].toString()),
                      );
                    }).toList(),
                    hintText: 'Select an option',
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    onChanged: (marketValue) {
                      controller.market.value = marketValue.toString();
                      controller.selectedMarketId = marketValue.toString();
                      controller.getSearchedShopDetail();
                    },
                  ),),
                  SizedBox(height: 5,),
                ],
              ),
            ),
            //DIVIDER
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom:0, left: 30, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shop List',
                      style:  GoogleFonts.publicSans(
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.keyboard_double_arrow_left),
                          onPressed: controller.previousPage,
                          disabledColor: Colors.grey,
                        ),
                        Obx(() => Text(
                          ' ${controller.currentPage.value}' ' to ${controller.totalPages.value}',
                          style:  GoogleFonts.publicSans(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        )),

                        // SizedBox(width: 5.0),
                        IconButton(
                          icon: Icon(Icons.keyboard_double_arrow_right),
                          onPressed: controller.nextPage,
                          disabledColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (controller.isPageLoading.value == true) {
                return Container(
                  height: 450,
                  width: 390,
                  child:  Center(
                    child:  SpinKitSpinningLines(
                      color: Colors.blue,
                      size: 70.0,
                    ),
                  ),
                );
              }  else if (controller.searchedShopListData.isEmpty) {
                return Container(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(80.0),
                        child: Image.asset(
                          "assets/images/addShop_img.png",),
                      ),
                      Text('No Data Available !!!')
                    ],
                  ),
                );
              }else {
                final startIndex = (controller.currentPage.value - 1) * controller.perPage;
                final endIndex = startIndex + controller.perPage;
                final displayedData = startIndex < controller.searchedShopListData.length
                    ? controller.searchedShopListData.sublist(startIndex,
                  endIndex < controller.searchedShopListData.length ? endIndex : controller.searchedShopListData.length,) : [];
                return SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: displayedData.length,
                    itemBuilder: (context, index) {
                      final propertyDetails = displayedData[index];
                      return  GestureDetector(
                        onTap: () async{
                          // Clear the list data before navigating
                          controller.clearData();
                          await controller.shopById(controller.searchedShopListData[index]['id']);
                          Get.to(() => PayShopRentByIdView(),
                           preventDuplicates: true,);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(20.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(0.1),
                              //     spreadRadius: 1,
                              //     blurRadius: 1,
                              //     offset: Offset(0, 1),
                              //   ),
                              // ],
                            ),
                            child: Card(
                              // margin: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              // elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildDetailsRow('Name', propertyDetails['allottee'].toString()),
                                        _buildDetailsRow('Shop No', propertyDetails['shop_no'].toString()),
                                        _buildDetailsRow('Last Paid on', propertyDetails['last_payment_date'].toString()),
                                        _buildDetailsRow('Address', propertyDetails['address'].toString()),
                                        _buildDetailsRow('Rate', propertyDetails['rate'].toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}


Widget _buildDetailsRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Text(
              label,
              style: GoogleFonts.publicSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  fontStyle:
                  FontStyle.normal),
            ),
          ),
        ),
        Flexible(
          child: Text(
           // value.isNotEmpty ? value : 'N/A',
            nullToNA(value),
          ),
        ),
      ],
    ),
  );
}
