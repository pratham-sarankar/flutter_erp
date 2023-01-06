import 'package:flutter_erp/app/data/providers/designation_provider.dart';
import 'package:flutter_erp/app/data/providers/employee_provider.dart';
import 'package:get/get.dart';

import '../controllers/employees_controller.dart';

class EmployeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeesController>(() => EmployeesController());
    Get.lazyPut<EmployeeProvider>(() => EmployeeProvider());
    Get.lazyPut<DesignationProvider>(() => DesignationProvider());
  }
}
