import 'package:flutter_erp/app/modules/class/controllers/chat_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_erp/app/modules/class/controllers/package_controller.dart';
import 'package:flutter_erp/app/modules/class/controllers/package_form_controller.dart';

import '../controllers/class_controller.dart';

class ClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageFormController>(
      () => PackageFormController(),
    );
    Get.lazyPut<PackageController>(
      () => PackageController(),
      tag: Get.parameters["id"],
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
      tag: Get.parameters['id'],
    );
    Get.lazyPut<ClassController>(
      () => ClassController(),
      tag: Get.parameters['id'],
    );
  }
}
