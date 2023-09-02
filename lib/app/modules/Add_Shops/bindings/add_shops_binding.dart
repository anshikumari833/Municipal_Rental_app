import 'package:get/get.dart';

import '../controllers/add_shops_controller.dart';

class AddShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddShopsController>(
      () => AddShopsController(),
    );
  }
}
