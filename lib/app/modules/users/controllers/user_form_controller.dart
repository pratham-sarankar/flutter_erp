import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/user.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

class UserFormController extends GetxController {
  late final GlobalKey<FormState> formKey;

  late User user;

  late RxBool isLoading;

  late RxString error;

  get isUpdating => user.id != null;

  @override
  void onInit() {
    user = Get.arguments ?? User();
    formKey = GlobalKey<FormState>();
    user = Get.arguments ?? User();
    isLoading = false.obs;
    error = "".obs;
    super.onInit();
  }

  void submit() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState!.save();
        if (isUpdating) {
          await Get.find<UserRepository>().update(user);
        } else {
          await Get.find<UserRepository>().insert(user);
        }
        Get.back(result: true);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
    }
  }
}
