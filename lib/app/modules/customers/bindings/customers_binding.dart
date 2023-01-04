import 'package:flutter_erp/app/data/providers/customer_provider.dart';
import 'package:flutter_erp/app/modules/customers/controllers/customer_dialog_controller.dart';
import 'package:get/get.dart';

import '../controllers/customers_controller.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController());
    Get.lazyPut<CustomerProvider>(() => CustomerProvider());
    Get.create<CustomerDialogController>(() => CustomerDialogController());
  }
}
