import 'package:get/get.dart';

import '../controllers/pay_toll_rent_controller.dart';

class PayTollRentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayTollRentController>(
      () => PayTollRentController(),
    );
  }
}
