import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/payment.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/branch_repository.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../data/models/class.dart';

class PaymentFormController extends GetxController {
  late GlobalKey<FormState> formKey;
  // late Subscription subscription;
  late Payment payment;
  late RxBool isLoading;
  late RxString error;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    payment = Payment(branchId: Get.find<AuthService>().currentBranch.id);
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
        await Get.find<PaymentRepository>().insert(payment);
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
