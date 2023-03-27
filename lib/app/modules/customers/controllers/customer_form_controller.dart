import 'package:flutter/cupertino.dart';

import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../data/models/customer.dart';

class CustomerFormController extends GetxController {
  late GlobalKey<FormState> formKey;

  // late Subscription subscription;
  late Customer customer;
  late RxBool isLoading;
  late RxString error;

  bool get isUpdating => Get.arguments != null;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    customer = Get.arguments ??
        Customer(branchId: Get.find<AuthService>().currentBranch.id);
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
          await Get.find<CustomerRepository>().update(customer);
        } else {
          await Get.find<CustomerRepository>().insert(customer);
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
