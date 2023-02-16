import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_repository.dart';
import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
    Get.lazyPut<PaymentRepository>(() => PaymentRepository());
    Get.create<CustomerRepository>(() => CustomerRepository());
  }
}
