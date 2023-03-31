import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/modules/customers/views/customer_table_view.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/widgets/resource_table_view.dart';

import '../../../data/models/customer.dart';
import '../controllers/customer_table_controller.dart';
import '../controllers/customers_controller.dart';

class CustomersView extends GetResponsiveView<CustomersController> {
  CustomersView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.CUSTOMERS,
      screen: screen,
      appBar: AppBar(
        title: const Text("All Customers"),
        actions: [
          IconButton(
            onPressed: Get.find<CustomerTableController>().refresh,
            icon: const Icon(CupertinoIcons.refresh),
          ),
          IconButton(
            onPressed: Get.find<CustomerTableController>().insertNew,
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: CustomerTableView(),
    );
  }
}
