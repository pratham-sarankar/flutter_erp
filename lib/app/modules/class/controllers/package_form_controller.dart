import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/package.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:get/get.dart';

class PackageFormController extends GetxController {
  late GlobalKey<FormState> formKey;
  late Package package;
  late RxBool isLoading;
  late RxString error;

  bool get isUpdating => (Get.arguments as Package).id != null;

  @override
  void onInit() {
    package = Get.arguments ?? Package();
    formKey = GlobalKey<FormState>();
    isLoading = false.obs;
    error = "".obs;
    super.onInit();
  }

  void submit() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState!.save();
        print(package.toMap());
        if (isUpdating) {
          await Get.find<PackageRepository>().update(package);
        } else {
          await Get.find<PackageRepository>().insert(package);
        }
        Get.back(result: true);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
      rethrow;
    }
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
