import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailsRow('Sairat Name : ', controller.idData_sairatName.toString()),
                  _buildDetailsRow('Present Occupier : ', controller.idData_presentOccupier.toString()),
                  _buildDetailsRow('Contact No : ', controller.idData_contactNo.toString()),
                  _buildDetailsRow('Circle : ', controller.idData_circle.toString()),
                  _buildDetailsRow('Market : ', controller.idData_market.toString()),
                  _buildDetailsRow('Address : ', controller.idData_address.toString()),
                  _buildDetailsRow('Monthly Rent : ', controller.idData_monthlyRent.toString()),
                  _buildDetailsRow('Last Demand : ', controller.idData_lastDemand.toString()),
                  _buildDetailsRow('Paid Upto : ', controller.idData_paidUpto.toString()),
                  _buildDetailsRow('Last Pmt on : ', controller.idData_lastPtmOn.toString()),
                ],
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       _buildDetailsRow('Sairat Name : ', controller.ShopListDataById[0]['allottee'].toString()),
            //       _buildDetailsRow('Present Occupier : ', controller.ShopListDataById[0]['present_occupier'].toString()),
            //       _buildDetailsRow('Contact No : ', controller.ShopListDataById[0]['contact_no'].toString()),
            //       _buildDetailsRow('Circle : ', controller.ShopListDataById[0]['circle_name'].toString()),
            //       _buildDetailsRow('Market : ', controller.ShopListDataById[0]['market_name'].toString()),
            //       _buildDetailsRow('Monthly Rent : ', controller.ShopListDataById[0]['rate'].toString()),
            //       _buildDetailsRow('Last Demand : ', controller.ShopListDataById[0]['last_payment_amount'].toString()),
            //       _buildDetailsRow('Paid Upto : ', controller.ShopListDataById[0]['payment_upto'].toString()),
            //       _buildDetailsRow('Last Pmt on : ', controller.ShopListDataById[0]['last_payment_date'].toString()),
            //     ],
            //   ),
            // ),
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
            value.isNotEmpty ? value : 'N/A',
            // nullToNA(value),
          ),
        ),
      ],
    ),
  );
}
