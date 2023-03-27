import 'package:get/get.dart';

import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:flutter_erp/app/modules/classes/controllers/classes_table_controller.dart';

import '../controllers/classes_controller.dart';
import '../controllers/classes_form_controller.dart';

class ClassesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassesTableController>(() => ClassesTableController());
    Get.lazyPut<ClassesController>(() => ClassesController());
    Get.lazyPut<ClassRepository>(() => ClassRepository());
    Get.create<EmployeeRepository>(() => EmployeeRepository());
  }
}
