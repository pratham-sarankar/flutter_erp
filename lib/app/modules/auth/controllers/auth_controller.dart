import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/modules/auth/enums/auth_mode.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late Rx<AuthMode> authMode;
  late RxString errorText;
  late RxBool isLoading;
  late GlobalKey<FormState> formKey;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    isLoading = false.obs;
    errorText = "".obs;
    authMode = Rx(AuthMode.login);
    formKey = GlobalKey<FormState>();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  void toggleAuthMode() {
    errorText.value = "";
    authMode.value = authMode.value.toggle;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void register() async {}

  void login() async {}
}
