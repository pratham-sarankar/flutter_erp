import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerTableController extends GetxController {
  late CustomersDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<Customer> selectedCustomers;
  late TextEditingController searchController;

  @override
  void onInit() {
    searchController = TextEditingController();
    source = CustomersDataSource();
    rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage.obs;
    sortAscending = true.obs;
    sortColumnIndex = 0.obs;
    selectedCustomers = <Customer>[].obs;
    super.onInit();
  }

  void setRowPerPage(int? newRowsPerPage) {
    rowsPerPage.value =
        newRowsPerPage ?? AdvancedPaginatedDataTable.defaultRowsPerPage;
  }

  void sort(int columnIndex, bool ascending) {
    sortAscending.value = ascending;
    sortColumnIndex.value = columnIndex;
    source.sort(columnIndex, ascending);
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

class CustomersDataSource extends AdvancedDataTableSource<Customer> {
  String lastSearchTerm = '';
  String sortingQuery = '';

  get selectedCustomers =>
      Get.find<CustomerTableController>().selectedCustomers;


  @override
  DataRow? getRow(int index) {
    var customer = lastDetails?.rows[index];
    return DataRow(
      selected: selectedCustomers.contains(customer),
      onSelectChanged: (value) {
        selectedRow(customer, value ?? false);
      },
      cells: [
        DataCell(Text(
          customer?.username ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          customer?.name ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          customer?.getEmail() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          customer?.phoneNumber ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          customer?.getDateOfBirth() ?? "",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
      ],
    );
  }

  @override
  bool get forceRemoteReload => true;

  @override
  int get selectedRowCount =>
      Get.find<CustomerTableController>().selectedCustomers.length;

  void selectedRow(Customer? customer, bool newSelectState) {
    if (selectedCustomers.contains(customer)) {
      selectedCustomers.remove(customer);
    } else {
      selectedCustomers.add(customer);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<Customer>> getNextPage(
      NextPageRequest pageRequest) async {
    var response = await Get.find<CustomerRepository>().fetchWithCount(
      offset: pageRequest.offset,
      limit: pageRequest.pageSize,
      queries: {
        "search": lastSearchTerm,
        "order": sortingQuery,
      },
    );
    return RemoteDataSourceDetails(
      response.total,
      response.data,
      filteredRows: lastSearchTerm.isEmpty ? null : response.data.length,
    );
  }

  @override
  void setNextView({int startIndex = 0}) {
    selectedCustomers.value = <Customer>[];
    super.setNextView(startIndex: startIndex);
  }

  @override
  bool requireRemoteReload() {
    if(lastSearchTerm.isNotEmpty){
      return selectedCustomers.value.isEmpty;
    }
    return lastDetails?.filteredRows!=null;
  }

  void sort(int columnIndex, bool ascending) {
    var columnName = "";
    switch (columnIndex) {
      case 0:
        columnName = "username";
        break;
      case 1:
        columnName = "full_name";
        break;
      case 2:
        columnName = "email";
        break;
      case 3:
        columnName = "phone_number";
        break;
      case 4:
        columnName = "date_of_birth";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }
}
