import 'package:flutter_erp/app/data/providers/branch_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<BranchProvider>(() => BranchProvider());
  }
}
