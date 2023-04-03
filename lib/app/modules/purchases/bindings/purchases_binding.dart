import 'package:get/get.dart';

import 'package:flutter_erp/app/modules/purchases/controllers/purchase_form_controller.dart';
import 'package:flutter_erp/app/modules/purchases/controllers/purchase_table_controller.dart';

import '../controllers/purchases_controller.dart';

class PurchasesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseTableController>(
      () => PurchaseTableController(),
      fenix: true,
    );
    Get.lazyPut<PurchasesController>(
      () => PurchasesController(),
    );
  }
}
