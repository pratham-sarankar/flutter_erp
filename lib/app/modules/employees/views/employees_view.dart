import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/modules/employees/controllers/employees_table_controller.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/modules/employees/controllers/employees_controller.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/widgets/resource_table_view.dart';

import 'employees_table_view.dart';

class EmployeesView extends GetResponsiveView<EmployeesController> {
  EmployeesView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.EMPLOYEES,
      screen: screen,
      appBar: AppBar(
        title: const Text("All Employees"),
        actions: [
          IconButton(
            onPressed: Get.find<EmployeesTableController>().refresh,
            icon: const Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: Get.find<EmployeesTableController>().insertNew,
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body:EmployeesTableView(),
    );
  }
}
