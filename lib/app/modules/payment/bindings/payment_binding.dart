import 'package:get/get.dart';

import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_repository.dart';
import 'package:flutter_erp/app/modules/payment/controllers/payment_form_controller.dart';
import 'package:flutter_erp/app/modules/payment/controllers/payment_table_controller.dart';

import '../controllers/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentFormController>(
      () => PaymentFormController(),
    );
    Get.lazyPut<PaymentTableController>(
      () => PaymentTableController(),
    );
    Get.lazyPut<PaymentController>(() => PaymentController());
    Get.lazyPut<PaymentRepository>(() => PaymentRepository());
    Get.create<CustomerRepository>(() => CustomerRepository());
  }
}
