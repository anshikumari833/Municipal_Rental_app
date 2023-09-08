import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/All_Common_Function.dart';
import '../controllers/pay_toll_rent_controller.dart';

class PayTollRentByIdView extends GetView<PayTollRentController> {
  const PayTollRentByIdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        elevation: 0,
        title: Text('Pay Toll Rent ',style: GoogleFonts.publicSans(
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
            CommonContainer(_buildDetailsRow('Vendor Name : ', controller.idData_VendorName.toString()),),
            CommonContainer(_buildDetailsRow('Contact No : ', controller.idData_mobileNo.toString()),),
            CommonContainer(_buildDetailsRow('Circle : ', controller.idData_circle.toString()),),
            CommonContainer(_buildDetailsRow('Market : ', controller.idData_market.toString()),),
            CommonContainer(_buildDetailsRow('Rate : ', controller.idData_Rate.toString()),),
            CommonContainer(_buildDetailsRow('Address : ', controller.idData_Address.toString()),),
            CommonContainer(_buildDetailsRow('Last Pmt on : ', controller.idData_lastPaymentDate),),
            CommonContainer(_buildDetailsRow('Last Pmt Amt : ', controller.idData_lastPymentAmt),),
            SizedBox(height: 20,),
          ],
        ),
      ),
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
            // value.isNotEmpty ? value : 'N/A',
            nullToNA(value),
          ),
        ),
      ],
    ),
  );
}
