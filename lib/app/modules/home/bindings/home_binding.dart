import 'package:flutter_erp/app/modules/home/controllers/customer_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerTabController>(
      () => CustomerTabController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
