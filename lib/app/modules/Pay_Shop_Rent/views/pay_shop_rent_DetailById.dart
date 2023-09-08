import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../MediaService/dart/Print reciept.dart';
import '../controllers/pay_shop_rent_controller.dart';

class PayShopRentByIdView extends GetView<PayShopRentController> {
  const PayShopRentByIdView({Key? key}) : super(key: key);
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
            CommonContainer(_buildDetailsRow('Sairat Name : ', controller.idData_sairatName.toString()),),
            CommonContainer(_buildDetailsRow('Present Occupier : ', controller.idData_presentOccupier.toString()),),
            CommonContainer(_buildDetailsRow('Contact No : ', controller.idData_contactNo.toString()),),
            CommonContainer( _buildDetailsRow('Circle : ', controller.idData_circle.toString()),),
            CommonContainer(_buildDetailsRow('Market : ', controller.idData_market.toString()),),
            CommonContainer(_buildDetailsRow('Rate : ', controller.idData_Rate.toString()),),
            CommonContainer( _buildDetailsRow('Address : ', controller.idData_address.toString()),),
            CommonContainer(_buildDetailsRow('Paid Upto : ', controller.idData_paidUpto),),
            CommonContainer(   _buildDetailsRow('Last Pmt on : ', controller.idData_lastPtmDate),),
             SizedBox(height: 20,),
            Column(
              children: [
                if (controller.idData_paidUpto.toString() == "")
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline,color: Colors.red,),
                                  Flexible(
                                    child: Text(
                                      '  Since last payment is not available, Please select a \n   month',
                                      style: GoogleFonts.publicSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.red[500]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Obx(() {
                            if (controller.dateSelected.value &&
                                controller.storeDateFrom.value.isNotEmpty &&
                                controller.storeDateUpto.value.isNotEmpty) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Month : ',
                                          style: GoogleFonts.publicSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              fontStyle:
                                              FontStyle.normal),
                                        ),
                                        Text(
                                          '${controller.diffBetweenDate()} (Month)',
                                          style: GoogleFonts.publicSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              fontStyle:
                                              FontStyle.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Payable Amount : ',
                                            style: GoogleFonts.publicSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                fontStyle:
                                                FontStyle.normal),
                                          ),
                                          Text(
                                            (controller.diffBetweenDate() * controller.idData_Rate).toString(),
                                            style: GoogleFonts.publicSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                fontStyle:
                                                FontStyle.normal),
                                          ),
                                        ],
                                      )

                                  ),
                                ],
                              );
                            } else { // Date is not selected or not in the correct format
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline),
                                    Text(
                                      '  Please select valid dates',
                                      style: GoogleFonts.publicSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
                          Obx(() {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'From Date :  ${controller.storeDateFrom.value}',
                                          style: GoogleFonts.publicSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              fontStyle:
                                              FontStyle.normal),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.selectDate(context, 'Select Date 1');
                                        },
                                        child: Text('From Date'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Upto Date :  ${controller.storeDateUpto.value}',
                                          style: GoogleFonts.publicSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              fontStyle:
                                              FontStyle.normal),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.selectDate(context, 'Select Date 2');
                                        },
                                        child: Text('Upto Date'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                if (controller.idData_paidUpto.toString() != "")
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.info_outline,color: Colors.red,),
                                Flexible(
                                  child: Text(
                                    '  Payment is done upto ${controller.idData_paidUpto}.For Advance \n   Payment Plese select Month',
                                    style: GoogleFonts.publicSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.red[500]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(() { return  Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Upto Date :  ${controller.selectedMonth.value}',
                                    style: GoogleFonts.publicSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        fontStyle:
                                        FontStyle.normal),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.selectMonth(context, 'Select DateUpto');
                                  },
                                  child: Text('Upto Date'),
                                ),
                              ],
                            ),
                          ),
                        );  }),
                        Obx(() {
                          if(controller.calculateMonthDifference() < 0){
                            return
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Advance Amount Paid : ',
                                        style: GoogleFonts.publicSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            fontStyle:
                                            FontStyle.normal),
                                      ),
                                      Text(
                                        ((controller.calculateMonthDifference().abs() ) * controller.idData_Rate).toString(),
                                        style: GoogleFonts.publicSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            fontStyle:
                                            FontStyle.normal),
                                      ),
                                    ],
                                  )
                              );
                          } else {
                            return  Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Payable Amount : ',
                                      style: GoogleFonts.publicSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          fontStyle:
                                          FontStyle.normal),
                                    ),
                                    Text(
                                      ((controller.calculateMonthDifference() ) * controller.idData_Rate).toString(),
                                      style: GoogleFonts.publicSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          fontStyle:
                                          FontStyle.normal),
                                    ),
                                  ],
                                )
                            );

                          }
                        }),
                        SizedBox(height: 20,)
                      ],
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal:60),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton.icon(
                  onPressed: () async{
                    Get.defaultDialog(
                      titlePadding: EdgeInsets.only(top:20,bottom: 4),
                      title: " Proceed to Pay",
                      middleText: "Press Confirm to pay",
                      // content: getContent(),
                      middleTextStyle: TextStyle(color: Colors.black54),
                      barrierDismissible: false,
                      backgroundColor: Colors.white,
                      radius: 10.0,
                      confirm: confirmBtn(),
                      cancel: cancelBtn(),
                    );
                  },
                  label: Text('Submit', style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.check, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:60),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton.icon(
                  onPressed: () async{
                    await controller.getShopReceipt();
                    Get.to(PrintReceipt(),
                        transition: Transition.rightToLeft,
                        duration: Duration(seconds: 1),
                        arguments: [
                          { 'print_string1': controller.getPrintString1()},
                          { 'print_string2': controller.getPrintString2()},
                          { 'print_string3': controller.getPrintString3()},
                        ],
                        preventDuplicates: true);
                  },
                  label: Text(' Print Receipt', style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.print, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 50,),//Submit
          ],
        )
      ),
    );
  }

  Widget confirmBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: () async {
        Get.back();
        await controller.ShopRentCollection();
      },
          child: Text("Confirm")),
    );
  }

  Widget cancelBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: () {
        Get.back();
      }, child: Text("Cancel")),
    );
  }

}




Widget CommonContainer(Widget child) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(1.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    ),
    child: child,
  );
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
            value.isNotEmpty ? value : 'N/A',
            // nullToNA(value),
          ),
        ),
      ],
    ),
  );
}
