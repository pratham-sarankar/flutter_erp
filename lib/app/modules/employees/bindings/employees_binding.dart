import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../controllers/employees_controller.dart';

class EmployeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeesController>(() => EmployeesController());
    Get.lazyPut<EmployeeRepository>(() => EmployeeRepository());
    Get.create<DesignationRepository>(() => DesignationRepository());
    Get.create<UserRepository>(() => UserRepository());
  }
}
