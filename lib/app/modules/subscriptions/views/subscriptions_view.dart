import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/coupon_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/modules/subscriptions/views/subscription_table_view.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/subscriptions_controller.dart';

class SubscriptionsView extends GetResponsiveView<SubscriptionsController> {
  SubscriptionsView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.SUBSCRIPTIONS,
      screen: screen,
      body: SubscriptionTableView(),
    );
  }
}
