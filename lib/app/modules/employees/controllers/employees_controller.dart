import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/employee_dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeesController extends GetxController {
  late Rx<EmployeeDataSource> dataSource;
  late RxList<Designation> designations;
  late RxBool isLoading;
  late RxBool isRefreshing;
  late RxBool isSelectionMode;

  @override
  void onInit() {
    isLoading = true.obs;
    isRefreshing = false.obs;
    isSelectionMode = false.obs;
    designations = <Designation>[].obs;
    init();
    super.onInit();
  }

  void sortByDesignation(int? designationId) async {
    isRefreshing.value = true;
    List<Employee> employees;
    if (designationId == null) {
      employees = await EmployeeRepository.instance.fetchAll();
    } else {
      employees = (await DesignationRepository.instance.fetchOne(designationId))
          .employees;
    }
    dataSource.value = EmployeeDataSource(
      employees: employees,
      designations: designations,
      onUpdate: updateEmployee,
      onDelete: deleteEmployee,
      onSelect: onSelectEmployee,
    );
    isRefreshing.value = false;
  }

  Future<void> init() async {
    var employees = await EmployeeRepository.instance.fetchAll();
    designations.value = await DesignationRepository.instance.fetch();
    dataSource = Rx(EmployeeDataSource(
      employees: employees,
      designations: designations,
      onUpdate: updateEmployee,
      onDelete: deleteEmployee,
      onSelect: onSelectEmployee,
    ));
    isLoading.value = false;
  }

  void createNewEmployee() async {
    Employee? employee = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => EmployeeDialog(designations: designations));
    if (employee == null) return;
    try {
      await EmployeeRepository.instance.insertOne(employee);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void updateEmployee(Employee employee) async {
    Employee? updatedEmployee = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) =>
            EmployeeDialog(employee: employee, designations: designations));
    if (updatedEmployee == null) return;
    try {
      await EmployeeRepository.instance.updateOne(updatedEmployee);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void deleteEmployee(Employee employee) async {
    try {
      bool sure = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => const ConfirmationDialog(
            message: "Are you sure you want to delete the selected Employee?"),
      );
      if (!sure) return;
      await EmployeeRepository.instance.deleteOne(employee);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void onSelectEmployee(List<Employee> employees) async {
    isSelectionMode.value = employees.isNotEmpty;
  }

  void deleteSelectedEmployees() async {
    isSelectionMode.value = false;
    try {
      bool sure = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => const ConfirmationDialog(
            message:
                "Are you sure you want to delete all the selected Employees?"),
      );
      if (!sure) return;
      List<Employee> employees = dataSource.value.selectedEmployees;
      await EmployeeRepository.instance.deleteMany(employees);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  Future<void> refresh() async {
    if (isRefreshing.value) return;
    isRefreshing.value = true;
    var employees = await EmployeeRepository.instance.fetchAll();
    designations.value = await DesignationRepository.instance.fetch();
    dataSource.value = EmployeeDataSource(
      employees: employees,
      designations: designations,
      onUpdate: updateEmployee,
      onDelete: deleteEmployee,
      onSelect: onSelectEmployee,
    );
    isRefreshing.value = false;
  }
}

class EmployeeDataSource extends DataTableSource {
  List<Employee> employees;
  List<Designation> designations;

  final Function(Employee) onUpdate;
  final Function(Employee) onDelete;
  final Function(List<Employee>) onSelect;

  EmployeeDataSource(
      {required this.employees,
      required this.designations,
      required this.onUpdate,
      required this.onDelete,
      required this.onSelect});

  final List<Employee> selectedEmployees = [];

  @override
  DataRow? getRow(int index) {
    return DataRow(
      onLongPress: () {
        onUpdate(employees[index]);
      },
      cells: [
        DataCell(Row(
          children: [
            if (employees[index].getPhotoUrl() != null)
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage:
                        NetworkImage(employees[index].getPhotoUrl()!),
                    onBackgroundImageError: (exception, stackTrace) {
                      print(exception);
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            Text(
              employees[index].getName(),
            ),
          ],
        )),
        DataCell(Text(employees[index].getEmail())),
        DataCell(Text(employees[index].getPhoneNumber())),
        DataCell(
          Text(designations
                  .firstWhere(
                      (element) => element.id == employees[index].designationId,
                      orElse: () => Designation(name: "-"))
                  .name ??
              "-"),
        ),
        DataCell(
          Row(
            children: [
              TextButton(
                onPressed: employees[index].phoneNumber == null
                    ? null
                    : () async {
                        Uri uri =
                            Uri.parse("tel:${employees[index].phoneNumber}");
                        await launchUrl(uri);
                      },
                child: Row(
                  children: const [
                    Icon(
                      Icons.phone_rounded,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Call",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              TextButton(
                onPressed: employees[index].email == null
                    ? null
                    : () async {
                        Uri uri = Uri.parse("mailto:${employees[index].email}");
                        await launchUrl(uri);
                      },
                child: Row(
                  children: const [
                    Icon(
                      Icons.mail_rounded,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Mail",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 10,
                offset: const Offset(0, 20),
                onSelected: (value) {
                  switch (value) {
                    case 0:
                      onUpdate(employees[index]);
                      break;
                    case 1:
                      onDelete(employees[index]);
                  }
                },
                itemBuilder: (context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 0,
                      height: 35,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.green.shade600,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Edit",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(height: 1),
                    PopupMenuItem(
                      value: 1,
                      height: 35,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 18,
                            color: Colors.red.shade700,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Delete",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                child: IgnorePointer(
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.zero,
                      ),
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      size: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
      selected: selectedEmployees.contains(employees[index]),
      onSelectChanged: (value) {
        if (value == null) return;
        if (value) {
          selectedEmployees.add(employees[index]);
        } else {
          selectedEmployees.remove(employees[index]);
        }
        notifyListeners();
        onSelect(selectedEmployees);
      },
    );
  }

  bool get hasData => employees.isNotEmpty;

  int get rowsPerPage => min(employees.length, 10);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => employees.length;

  @override
  int get selectedRowCount => 0;
}
