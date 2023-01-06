import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/utils/resource_manager//table_view.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/customer_dialog.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/models/customer.dart';
import '../controllers/customers_controller.dart';

class CustomersView extends GetResponsiveView<CustomersController> {
  CustomersView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.CUSTOMERS,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Container(
          margin:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: TableView<Customer>(
            title: "All Customers",
            repository: CustomerRepository.instance,
            onCreate: () async {
              Customer customer = await Get.dialog(const CustomerDialog());
              return customer;
            },
            onUpdate: (value) async {
              Customer? customer =
                  await Get.dialog(const CustomerDialog(), arguments: value);
              return customer;
            },
            onDelete: (value) async {
              bool? sure = await Get.dialog(const ConfirmationDialog(
                  message: "Are you sure you want to perform this action?"));
              return sure ?? false;
            },
          ),
        ),
      ),
    );
  }
}
