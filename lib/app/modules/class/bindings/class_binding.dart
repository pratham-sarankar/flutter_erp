import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_duration_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/class_controller.dart';

class ClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<ClassController>(() => ClassController());
    Get.lazyPut<ClassRepository>(() => ClassRepository());
    Get.lazyPut<PackageRepository>(() => PackageRepository());
    Get.create<PackageDurationRepository>(() => PackageDurationRepository());
    Get.create<SubscriptionRepository>(() => SubscriptionRepository());
  }
}
