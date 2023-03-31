import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/branch_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/data.dart';

import '../../../data/models/employee.dart';

class EmployeesFormController extends GetxController {
  late GlobalKey<FormState> formKey;
  late Employee employee;
  late RxBool isLoading;
  late RxString error;

  bool get isUpdating => Get.arguments != null;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    employee = Get.arguments ??
        Employee(branchId: Get.find<AuthService>().currentBranch.id);
    isLoading = false.obs;
    error = "".obs;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void submit() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState!.save();
        if (isUpdating) {
          await Get.find<EmployeeRepository>().update(employee);
        } else {
          await Get.find<EmployeeRepository>().insert(employee);
        }
        Get.back(result: true);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
