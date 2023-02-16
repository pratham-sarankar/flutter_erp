import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:get/get.dart';

import '../controllers/designations_controller.dart';

class DesignationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesignationsController>(() => DesignationsController());
    Get.lazyPut<DesignationRepository>(() => DesignationRepository());
  }
}
