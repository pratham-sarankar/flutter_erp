import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:get/get.dart';

class CustomerTabController extends GetxController {
  late CustomerDataSource dataSource;
  late RxBool isLoading;

  @override
  void onInit() {
    isLoading = true.obs;
    fetchCustomers();
    super.onInit();
  }

  void fetchCustomers() async {
    var customers = await CustomerRepository.instance.fetchAll();
    dataSource = CustomerDataSource(customers: customers);
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class CustomerDataSource extends DataTableSource {
  late final List<Customer> customers;

  CustomerDataSource({required this.customers});

  bool get hasData => customers.isNotEmpty;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(customers[index].getName())),
        DataCell(Text(customers[index].getEmail())),
        DataCell(Text(customers[index].getPhoneNumber())),
        DataCell(Text(customers[index].getDateOfBirth())),
        DataCell(
          Row(
            children: [
              TextButton(
                onPressed: () {},
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
                onPressed: () {},
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
              TextButton(
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
              )
            ],
          ),
        ),
      ],
      onSelectChanged: (value) {},
    );
  }

  int get rowsPerPage => customers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => customers.length;

  @override
  int get selectedRowCount => 0;
}
