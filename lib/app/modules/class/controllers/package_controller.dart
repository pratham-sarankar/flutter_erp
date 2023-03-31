import 'package:flutter_erp/app/data/models/package.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/modules/class/views/package_form_view.dart';
import 'package:get/get.dart';

class PackageController extends GetxController {
  late RxList<Package> packages;

  @override
  void onInit() {
    packages = <Package>[].obs;
    initialize();
    super.onInit();
  }

  void initialize() async {
    final packages = await Get.find<PackageRepository>().fetch(
      queries: {
        "class_id": Get.parameters["id"],
      },
    );

    this.packages.value = packages;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void insertPackage() async {
    var result = await Get.dialog(
      const PackageFormView(),
      barrierDismissible: false,
      arguments: Package(classId: int.parse(Get.parameters["id"]!)),
    );
    if (result) {
      reload();
    }
  }

  void reload() {
    initialize();
  }
}
