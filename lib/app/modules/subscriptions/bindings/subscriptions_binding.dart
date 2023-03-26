import 'package:get/get.dart';

import 'package:flutter_erp/app/modules/subscriptions/controllers/subscription_form_controller.dart';
import 'package:flutter_erp/app/modules/subscriptions/controllers/subscription_table_controller.dart';

import '../controllers/subscriptions_controller.dart';

class SubscriptionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionTableController>(
      () => SubscriptionTableController(),
      fenix: true,
    );
    Get.lazyPut<SubscriptionsController>(() => SubscriptionsController());
  }
}
