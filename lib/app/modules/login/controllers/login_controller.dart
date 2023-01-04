import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/Users/user.dart';
import 'package:flutter_erp/app/data/models/users/user_credential.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

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
      await UserRepository.instance.login(
          credential: UserCredential(
        user: User(
          username: usernameController.text,
        ),
        password: passwordController.text,
      ));
      isLoading.value = false;
      Get.toNamed(Routes.HOME);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
  }
}
