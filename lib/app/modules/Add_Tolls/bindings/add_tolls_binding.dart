import 'package:get/get.dart';

import '../controllers/add_tolls_controller.dart';

class AddTollsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTollsController>(
      () => AddTollsController(),
    );
  }
}
