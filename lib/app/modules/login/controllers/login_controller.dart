import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class LoginController extends GetxController {
  late RxString errorText;
  late RxBool isLoading;
  late GlobalKey<FormState> formKey;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    isLoading = false.obs;
    errorText = "".obs;
    formKey = GlobalKey<FormState>();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  void login() async {
    try {
      isLoading.value = true;
      await Get.find<UserRepository>()
          .login(usernameController.text, passwordController.text);
      isLoading.value = false;
      Get.offAllNamed(Routes.HOME);
    } on ApiException catch (e) {
      isLoading.value = false;
      Get.find<ToastService>().showToast(e.message);
    }
  }
}
