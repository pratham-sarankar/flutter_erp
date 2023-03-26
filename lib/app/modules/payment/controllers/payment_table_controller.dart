import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_repository.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrule/rrule.dart';

import '../../../data/models/course.dart';
import '../../../data/models/employee.dart';
import '../../../data/models/payment.dart';

class PaymentTableController extends GetxController {
  late PaymentDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<int> selectedIds;
  late TextEditingController searchController;

  @override
  void onInit() {
    searchController = TextEditingController();
    source = PaymentDataSource();
    rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage.obs;
    sortAscending = true.obs;
    sortColumnIndex = 0.obs;
    selectedIds = <int>[].obs;
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
  void refresh() {
    source.refresh();
    super.refresh();
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

class PaymentDataSource extends AdvancedDataTableSource<Payment> {
  String lastSearchTerm = '';
  String sortingQuery = '';
  bool remoteReload = false;

  RxList<int> get selectedIds => Get.find<PaymentTableController>().selectedIds;

  @override
  DataRow? getRow(int index) {
    var paymentDetails = lastDetails?.rows[index];
    return DataRow(
      selected: selectedIds.contains(paymentDetails?.id),
      onSelectChanged: (value) {
        selectedRow(paymentDetails?.id, value ?? false);
      },
      cells: [
        DataCell(Text(
          paymentDetails?.amount?.toString() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          paymentDetails?.description ?? "",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          paymentDetails?.customer?.name ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
      ],
    );
  }

  @override
  int get selectedRowCount => selectedIds.length;

  void selectedRow(int? id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id!);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  void refresh() {
    setNextView();
    notifyListeners();
  }

  @override
  Future<RemoteDataSourceDetails<Payment>> getNextPage(
      NextPageRequest pageRequest) async {
    var response = await Get.find<PaymentRepository>().fetchWithCount(
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
    selectedIds.value = <int>[];
    remoteReload = true;
    super.setNextView(startIndex: startIndex);
    remoteReload = false;
  }

  @override
  bool requireRemoteReload() {
    if (lastSearchTerm.isNotEmpty) {
      return selectedIds.isEmpty;
    }
    return remoteReload || lastDetails?.filteredRows != null;
  }

  void sort(int columnIndex, bool ascending) {
    var columnName = "";
    switch (columnIndex) {
      case 0:
        columnName = "amount";
        break;
      case 1:
        columnName = "description";
        break;
      case 3:
        columnName = "customer";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }
}
