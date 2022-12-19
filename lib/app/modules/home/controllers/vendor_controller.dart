import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/vendor.dart';
import 'package:flutter_erp/app/data/repositories/vendor_repository.dart';
import 'package:get/get.dart';

class VendorTabController extends GetxController {
  late RxList<bool> selectedList;
  late Rx<VendorDataSource> dataSource;

  @override
  void onInit() {
    dataSource = Rx(VendorDataSource());
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

class VendorDataSource extends DataTableSource {
  late RxList<Vendor> _vendors;
  late RxList<Vendor> _searchedVendors;
  late RxList<Vendor> _selectedVendors;
  late RxInt _sortIndex;
  late RxBool _ascending;

  List<Vendor> get vendors => _vendors;
  bool get ascending => _ascending.value;
  int get rowsPerPage => min(_vendors.length, 10);
  int get sortIndex => _sortIndex.value;

  set setSortIndex(int index) {
    _sortIndex.value = index;
  }

  set setAscending(bool value) {
    _ascending.value = value;
  }

  VendorDataSource() {
    _vendors = <Vendor>[].obs;
    _selectedVendors = <Vendor>[].obs;
    _searchedVendors = <Vendor>[].obs;
    _sortIndex = 0.obs;
    _ascending = true.obs;
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    List<Vendor> vendors = await VendorRepository.instance.fetchAll();
    _vendors.value = vendors;
    _searchedVendors.value = _vendors;
  }

  void sortByName() {
    _searchedVendors.sort((a, b) {
      return a.name!.toLowerCase().compareTo(b.name!.toLowerCase()) *
          (ascending ? -1 : 1);
    });
    notifyListeners();
  }

  void addVendor() async {
    // Vendor? vendor = await Get.dialog(
    //   const AddVendorModal(),
    //   barrierDismissible: false,
    // ) as Vendor?;
    // print(vendor);
    // if (vendor != null) {
    //   await VendorRepository.instance.insertOne(vendor);
    //   var vendors = await VendorRepository.instance.fetchAll();
    //   _vendors.value = vendors;
    //   _searchedVendors.value = vendors;
    //   notifyListeners();
    // }
  }

  void onSearchUpdate(String value) {
    _searchedVendors.value =
        _vendors.where((customer) => customer.doesMatch(value)).toList();
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
              if (_searchedVendors[index].photoURL != null)
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(_searchedVendors[index].photoURL!),
                ),
              if (_searchedVendors[index].photoURL != null)
                const SizedBox(width: 8),
              Text(_searchedVendors[index].name!),
            ],
          ),
        ),
        DataCell(
          Text(
            _searchedVendors[index].mobileNo ?? 'None',
          ),
        ),
        DataCell(
          Text(
            _searchedVendors[index].emailId ?? 'None',
          ),
        ),
        DataCell(
          Text(
            _searchedVendors[index].gstin ?? 'None',
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
      selected: _selectedVendors.contains(_vendors[index]),
      onSelectChanged: (selected) {
        if (selected!) {
          _selectedVendors.add(_vendors[index]);
        } else {
          _selectedVendors.remove(_vendors[index]);
        }
        notifyListeners();
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _searchedVendors.length;

  @override
  int get selectedRowCount => 0;
}
