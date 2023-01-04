import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/customer_dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomersController extends GetxController {
  late Rx<CustomerDataSource> dataSource;
  late RxBool isLoading;
  late RxBool isRefreshing;
  late RxBool isSelectionMode;

  @override
  void onInit() {
    isLoading = true.obs;
    isRefreshing = false.obs;
    isSelectionMode = false.obs;
    init();
    super.onInit();
  }

  Future<void> init() async {
    var employees = await CustomerRepository.instance.fetch();
    dataSource = Rx(CustomerDataSource(
      customers: employees,
      onUpdate: updateCustomer,
      onDelete: deleteEmployee,
      onSelect: onSelectCustomer,
    ));
    isLoading.value = false;
  }

  void createNewCustomer() async {
    Customer? customer = await Get.dialog(const CustomerDialog());
    if (customer == null) return;
    try {
      await CustomerRepository.instance.insert(customer);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void updateCustomer(Customer customer) async {
    Customer? updatedCustomer =
        await Get.dialog(const CustomerDialog(), arguments: customer);
    if (updatedCustomer == null) return;
    try {
      await CustomerRepository.instance.update(updatedCustomer);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void deleteEmployee(Customer customer) async {
    try {
      bool sure = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => const ConfirmationDialog(
            message: "Are you sure you want to delete the selected Employee?"),
      );
      if (!sure) return;
      await CustomerRepository.instance.destroy(customer);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void onSelectCustomer(List<Customer> customers) async {
    isSelectionMode.value = customers.isNotEmpty;
  }

  void deleteSelectedCustomers() async {
    isSelectionMode.value = false;
    try {
      bool sure = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => const ConfirmationDialog(
            message:
                "Are you sure you want to delete all the selected Customers?"),
      );
      if (!sure) return;
      List<Customer> customers = dataSource.value.selectedCustomers;
      await CustomerRepository.instance.destroyMany(customers);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  Future<void> refresh() async {
    if (isRefreshing.value) return;
    isRefreshing.value = true;
    var employees = await CustomerRepository.instance.fetch();
    dataSource.value = CustomerDataSource(
      customers: employees,
      onUpdate: updateCustomer,
      onDelete: deleteEmployee,
      onSelect: onSelectCustomer,
    );
    isRefreshing.value = false;
  }
}

class CustomerDataSource extends DataTableSource {
  List<Customer> customers;

  final Function(Customer) onUpdate;
  final Function(Customer) onDelete;
  final Function(List<Customer>) onSelect;

  CustomerDataSource(
      {required this.customers,
      required this.onUpdate,
      required this.onDelete,
      required this.onSelect});

  final List<Customer> selectedCustomers = [];

  @override
  DataRow? getRow(int index) {
    return DataRow(
      onLongPress: () {
        onUpdate(customers[index]);
      },
      cells: [
        DataCell(Row(
          children: [
            if (customers[index].getPhotoUrl() != null)
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage:
                        NetworkImage(customers[index].getPhotoUrl()!),
                    onBackgroundImageError: (exception, stackTrace) {
                      print(exception);
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            Text(
              customers[index].getName(),
            ),
          ],
        )),
        DataCell(Text(customers[index].getEmail())),
        DataCell(Text(customers[index].getPhoneNumber())),
        DataCell(
          Row(
            children: [
              TextButton(
                onPressed: customers[index].phoneNumber == null
                    ? null
                    : () async {
                        Uri uri =
                            Uri.parse("tel:${customers[index].phoneNumber}");
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
                onPressed: customers[index].email == null
                    ? null
                    : () async {
                        Uri uri = Uri.parse("mailto:${customers[index].email}");
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
                      onUpdate(customers[index]);
                      break;
                    case 1:
                      onDelete(customers[index]);
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
      selected: selectedCustomers.contains(customers[index]),
      onSelectChanged: (value) {
        if (value == null) return;
        if (value) {
          selectedCustomers.add(customers[index]);
        } else {
          selectedCustomers.remove(customers[index]);
        }
        notifyListeners();
        onSelect(selectedCustomers);
      },
    );
  }

  bool get hasData => customers.isNotEmpty;

  int get rowsPerPage => min(customers.length, 10);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => customers.length;

  @override
  int get selectedRowCount => 0;
}
