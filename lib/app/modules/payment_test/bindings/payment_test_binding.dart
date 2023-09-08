import 'package:get/get.dart';

import '../controllers/payment_test_controller.dart';

class PaymentTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentTestController>(
      () => PaymentTestController(),
    );
  }
}
