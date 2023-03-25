import 'package:get/get.dart';

import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/coupon_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_mode_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/modules/subscriptions/controllers/subscription_form_controller.dart';
import 'package:flutter_erp/app/modules/subscriptions/controllers/subscription_table_controller.dart';

import '../controllers/subscriptions_controller.dart';

class SubscriptionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionFormController>(
      () => SubscriptionFormController(),
    );
    Get.lazyPut<SubscriptionTableController>(
        () => SubscriptionTableController());
    Get.lazyPut<SubscriptionsController>(() => SubscriptionsController());
    Get.lazyPut<SubscriptionRepository>(() => SubscriptionRepository());
    Get.create<CustomerRepository>(() => CustomerRepository());
    Get.create<ClassRepository>(() => ClassRepository());
    Get.create<PackageRepository>(() => PackageRepository());
    Get.create<PaymentModeRepository>(() => PaymentModeRepository());
    Get.create<CouponRepository>(() => CouponRepository());
  }
}
