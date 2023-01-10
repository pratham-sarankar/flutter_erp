import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:get/get.dart';

import '../controllers/class_controller.dart';

class ClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassController>(() => ClassController());
    Get.lazyPut<ClassRepository>(() => ClassRepository());
  }
}
