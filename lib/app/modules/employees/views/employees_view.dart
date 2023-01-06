import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/utils/resource_manager//table_view.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/employee_dialog.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/modules/employees/controllers/employees_controller.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class EmployeesView extends GetResponsiveView<EmployeesController> {
  EmployeesView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.EMPLOYEES,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Container(
          margin:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: TableView<Employee>(
            title: "All Customers",
            repository: EmployeeRepository.instance,
            onDelete: (value) async {
              bool? sure = await Get.dialog(const ConfirmationDialog(
                  message: "Are you sure you want to perform this action?"));
              return sure ?? false;
            },
            onUpdate: (value) async {
              Employee? updatedEmployee =
                  await Get.dialog(EmployeeDialog(employee: value));
              return updatedEmployee;
            },
            onCreate: () async {
              Employee employee = await Get.dialog(const EmployeeDialog());
              return employee;
            },
          ),
        ),
      ),
    );
  }
}
