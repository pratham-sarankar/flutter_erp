import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:get/get.dart';

import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/modules/classes/controllers/class_form_controller.dart';

import '../controllers/classes_controller.dart';

class ClassesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassFormController>(() => ClassFormController());
    Get.lazyPut<ClassesController>(() => ClassesController());
    Get.lazyPut<ClassRepository>(() => ClassRepository());
    Get.create<EmployeeRepository>(() => EmployeeRepository());
  }
}
