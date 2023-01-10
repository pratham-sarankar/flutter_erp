import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:get/get.dart';

import '../controllers/customers_controller.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController());
    Get.lazyPut<CustomerRepository>(() => CustomerRepository());
  }
}
