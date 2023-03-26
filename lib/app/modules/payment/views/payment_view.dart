import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/payment.dart';
import 'package:flutter_erp/app/data/repositories/payment_repository.dart';
import 'package:flutter_erp/app/modules/payment/views/payment_table_view.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/widgets/resource_table_view.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetResponsiveView<PaymentController> {
  PaymentView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.PAYMENT,
      screen: screen,
      body:PaymentTableView(),
    );
  }
}
