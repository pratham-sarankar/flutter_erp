import 'package:get/get.dart';

import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/modules/employees/controllers/employees_form_controller.dart';

import '../controllers/employees_controller.dart';
import '../controllers/employees_table_controller.dart';

class EmployeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeesFormController>(
      () => EmployeesFormController(),
    );
    Get.lazyPut<EmployeesTableController>(
      () => EmployeesTableController(),
    );
    Get.lazyPut<EmployeesController>(() => EmployeesController());
    Get.lazyPut<EmployeeRepository>(() => EmployeeRepository());
    Get.create<DesignationRepository>(() => DesignationRepository());
    Get.create<UserRepository>(() => UserRepository());
  }
}
