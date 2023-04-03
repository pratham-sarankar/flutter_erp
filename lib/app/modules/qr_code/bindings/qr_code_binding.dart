import 'package:get/get.dart';

import 'package:flutter_erp/app/modules/qr_code/controllers/qr_enquiry_controller.dart';

import '../controllers/qr_code_controller.dart';

class QrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrEnquiryController>(
      () => QrEnquiryController(),
    );
    Get.lazyPut<QrCodeController>(
      () => QrCodeController(),
    );
  }
}
