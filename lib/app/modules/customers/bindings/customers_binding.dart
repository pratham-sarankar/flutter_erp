import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_mode_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/abstracts/repository.dart';
import 'package:resource_manager/widgets/resource_table_view.dart';

import '../controllers/customers_controller.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController());
    Get.lazyPut<CustomerRepository>(() => CustomerRepository());
    Get.create<SubscriptionRepository>(()=>SubscriptionRepository());
    Get.create<ClassRepository>(()=>ClassRepository());
    Get.create<PackageRepository>(()=>PackageRepository());
    Get.create<PaymentModeRepository>(()=>PaymentModeRepository());
    Get.create<TableController<Subscription>>(() => TableController<Subscription>(Get.find<SubscriptionRepository>()));
  }
}
