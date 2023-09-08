import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../MediaService/dart/PineLab_methodChannel.dart';
import '../controllers/payment_test_controller.dart';

class PaymentTestView extends GetView<PaymentTestController> {
  const PaymentTestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Payment Test Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("This screen is only for test purpose",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),
            ElevatedButton(
              onPressed: () async {
               // await controller.sendIntentToPineLabs();
               await controller.openPinePOS();
              // await PaymentService.sendIntentToPineLabs();
              },
              child: Text('Send Intent to Pine Labs'),
            ),
          ],
        )

      ),
    );
  }
}
