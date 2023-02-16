import 'package:flutter_erp/app/data/repositories/coupon_repository.dart';
import 'package:get/get.dart';

import '../controllers/coupon_controller.dart';

class CouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponController>(() => CouponController());
    Get.lazyPut<CouponRepository>(() => CouponRepository());
  }
}
