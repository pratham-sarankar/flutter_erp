import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/coupon_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/subscriptions_controller.dart';

class SubscriptionsView extends GetResponsiveView<SubscriptionsController> {
  SubscriptionsView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    Get.find<CouponRepository>().fetch().then((value) => print(value));
    return ErpScaffold(
      path: Routes.SUBSCRIPTIONS,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Container(
          margin:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ResourceTableView<Subscription>(
            title: "All Subscriptions",
            repository: Get.find<SubscriptionRepository>(),
          ),
        ),
      ),
    );
  }
}
