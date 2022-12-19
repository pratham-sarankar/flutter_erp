import 'package:get/get.dart';

import '../controllers/employees_controller.dart';

class EmployeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeesController>(
      () => EmployeesController(),
    );
  }
}
