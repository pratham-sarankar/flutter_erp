import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  late TextEditingController password;
  late TextEditingController newPassword;
  late RxBool isLoading;

  @override
  void onInit() {
    isLoading = false.obs;
    password = TextEditingController();
    newPassword = TextEditingController();
    super.onInit();
  }

  void updatePassword() async {
    isLoading.value = true;
    await Get.find<UserRepository>()
        .updatePassword(password.text, newPassword.text);
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
