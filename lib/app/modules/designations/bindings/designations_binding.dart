import 'package:flutter_erp/app/data/providers/designation_provider.dart';
import 'package:get/get.dart';

import '../controllers/designations_controller.dart';

class DesignationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesignationsController>(() => DesignationsController());
    Get.lazyPut<DesignationProvider>(() => DesignationProvider());
  }
}
