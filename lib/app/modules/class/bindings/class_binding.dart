import 'package:flutter_erp/app/data/providers/class_provider.dart';
import 'package:flutter_erp/app/modules/class/controllers/class_dialog_controller.dart';
import 'package:get/get.dart';

import '../controllers/class_controller.dart';

class ClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassController>(() => ClassController());
    Get.lazyPut<ClassProvider>(() => ClassProvider());
    Get.create<ClassDialogController>(() => ClassDialogController());
  }
}
