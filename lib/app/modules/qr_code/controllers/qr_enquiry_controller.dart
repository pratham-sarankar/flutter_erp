import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:get/get.dart';

class QrEnquiryController extends GetxController {
  late GlobalKey<FormState> formKey;
  late Customer customer;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    customer = Get
        .find<CustomerRepository>()
        .empty;
    super.onInit();
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final customers = await Get.find<CustomerRepository>().fetch(queries: {
        "phoneNumber": customer.phoneNumber,
      });
      if (customers.isNotEmpty) {
        customer = customers.first;
      }

      Get.back();
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
