import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customers.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/utils/extensions/datetime.dart';
import 'package:get/get.dart';

class CustomerTabController extends GetxController {
  late RxList<bool> selectedList;

  late Rx<CustomerDataSource> dataSource;

  @override
  void onInit() {
    dataSource = Rx(CustomerDataSource());
    super.onInit();
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
  late RxBool _isLoading;
  late RxList<Customer> _customers;
  late RxList<Customer> _selectedCustomers;
  late RxInt _sortIndex;
  late RxBool _ascending;

  bool get isLoading => _isLoading.value;
  bool get ascending => _ascending.value;
  int get sortIndex => _sortIndex.value;

  set setSortIndex(int index) {
    _sortIndex.value = index;
  }

  set setAscending(bool value) {
    _ascending.value = value;
  }

  CustomerDataSource() {
    _isLoading = true.obs;
    _customers = <Customer>[].obs;
    _selectedCustomers = <Customer>[].obs;
    _sortIndex = 0.obs;
    _ascending = true.obs;
    _initCustomers();
  }

  Future<void> _initCustomers() async {
    _customers.value = await CustomerRepository.instance.getDummyCustomers();
    _isLoading.value = false;
  }

  void sortByName() {
    _customers.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase()) *
          (ascending ? -1 : 1);
    });
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(
      color: MaterialStateColor.resolveWith(
        (states) {
          return Colors.transparent;
        },
      ),
      cells: <DataCell>[
        DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(_customers[index].photoURL),
              ),
              const SizedBox(width: 8),
              Text(_customers[index].name),
            ],
          ),
        ),
        DataCell(
          Text(_customers[index].memberSince.format("MMM dd, yyyy")),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            child: const Text("Gold"),
          ),
        ),
        DataCell(
          Text(
            "₹${_customers[index].totalPurchased.toString()}",
          ),
        ),
        DataCell(
          Text(
            _customers[index].totalVisits.toString(),
          ),
        ),
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
      selected: _selectedCustomers.contains(_customers[index]),
      onSelectChanged: (selected) {
        if (selected!) {
          _selectedCustomers.add(_customers[index]);
        } else {
          _selectedCustomers.remove(_customers[index]);
        }
        notifyListeners();
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _customers.length;

  @override
  int get selectedRowCount => 0;
}
