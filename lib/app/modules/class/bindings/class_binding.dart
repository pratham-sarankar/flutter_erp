import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/coupon_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_duration_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_mode_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/modules/class/controllers/chat_controller.dart';
import 'package:flutter_erp/app/modules/class/controllers/package_controller.dart';

import '../controllers/class_controller.dart';

class ClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageController>(
      () => PackageController(),
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.create<ClassController>(() => ClassController());
    Get.lazyPut<ClassRepository>(() => ClassRepository());
    Get.lazyPut<PackageRepository>(() => PackageRepository());
    Get.create<PackageDurationRepository>(() => PackageDurationRepository());
    Get.lazyPut<CustomerRepository>(() => CustomerRepository());
    Get.create<SubscriptionRepository>(() => SubscriptionRepository());
    Get.create<PaymentModeRepository>(() => PaymentModeRepository());
    Get.create<CouponRepository>(() => CouponRepository());
    Get.create<TableController<Subscription>>(() =>
        TableController<Subscription>(Get.find<SubscriptionRepository>()));
  }
}
