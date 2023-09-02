import 'package:get/get.dart';

import '../controllers/pay_shop_rent_controller.dart';

class PayShopRentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayShopRentController>(
      () => PayShopRentController(),
    );
  }
}
