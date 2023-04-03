import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/purchases/controllers/purchase_table_controller.dart';
import 'package:flutter_erp/app/modules/purchases/controllers/purchases_controller.dart';
import 'package:flutter_erp/app/modules/purchases/views/purchase_table_view.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class PurchasesView extends GetResponsiveView<PurchasesController> {
  PurchasesView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.PURCHASES,
      screen: screen,
      appBar: AppBar(
        title: const Text("All Purchases"),
        actions: [
          IconButton(
            onPressed: Get.find<PurchaseTableController>().refresh,
            icon: const Icon(CupertinoIcons.refresh),
          ),
          IconButton(
            onPressed: Get.find<PurchaseTableController>().insertNew,
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: PurchaseTableView(),
    );
  }
}
