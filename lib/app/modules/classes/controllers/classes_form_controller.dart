import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:get/get.dart';

class ClassesFormController extends GetxController with StateMixin<Class> {
  late GlobalKey<FormState> formKey;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    change(Get.arguments ?? Get
        .find<ClassRepository>()
        .empty);
    super.onInit();
  }

  Class? getValue() {
    return value;
  }

  String getTitle() {
    if (Get.arguments == null) {
      return "Add Class";
    }
    return "Edit Class";
  }

  void updateClass(Class? Function(Class) updateClass) {
    var update = updateClass(value ?? Get
        .find<ClassRepository>()
        .empty);
    change(update,
        status: update == null ? RxStatus.error() : RxStatus.success());
  }

  void saveAndClose() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      Get.back(result: value);
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
