import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/modules/customers/views/customer_table_view.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/widgets/resource_table_view.dart';

import '../../../data/models/customer.dart';
import '../controllers/customers_controller.dart';

class CustomersView extends GetResponsiveView<CustomersController> {
  CustomersView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.CUSTOMERS,
      screen: screen,
      body: CustomerTableView(),
    );
  }
}
