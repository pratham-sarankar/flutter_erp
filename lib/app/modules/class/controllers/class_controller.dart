import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:get/get.dart';

class ClassController extends GetxController with StateMixin<Class> {
  late final int id;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    id = int.parse(Get.parameters['id'] ?? "0");
    var value = await Get.find<ClassRepository>().fetchOne(id);
    change(value, status: RxStatus.success());
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
