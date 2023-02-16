import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:get/get.dart';

import '../controllers/classes_controller.dart';

class ClassesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassesController>(() => ClassesController());
    Get.lazyPut<ClassRepository>(() => ClassRepository());
    Get.create<EmployeeRepository>(() => EmployeeRepository());
  }
}
