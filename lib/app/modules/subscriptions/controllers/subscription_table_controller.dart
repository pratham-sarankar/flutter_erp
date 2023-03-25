import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionTableController extends GetxController {
  late SubscriptionDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;

  @override
  void onInit() {
    source = SubscriptionDataSource();
    rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage.obs;
    sortAscending = true.obs;
    sortColumnIndex = 0.obs;

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

class SubscriptionDataSource extends AdvancedDataTableSource<Subscription> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  String sortingQuery = '';

  @override
  DataRow? getRow(int index) {
    var subscription = lastDetails?.rows[index];
    return DataRow(
      selected: selectedIds.contains(subscription?.id.toString() ?? ""),
      onSelectChanged: (value) {
        selectedRow(subscription?.id.toString() ?? "", value ?? false);
      },
      cells: [
        DataCell(
          Text(
            subscription?.customer?.name ?? "",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(Text(
          subscription?.package?.classDetails?.title ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          subscription?.package?.name ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          subscription?.payment?.mode?.title ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          subscription?.getExpiringDate() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          subscription?.getSubscribedDate() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<Subscription>> getNextPage(
      NextPageRequest pageRequest) async {
    var response = await Get.find<SubscriptionRepository>().fetchWithCount(
      offset: pageRequest.offset,
      limit: pageRequest.pageSize,
      queries: {
        "search": lastSearchTerm,
        "order": sortingQuery,
      },
    );
    return RemoteDataSourceDetails(response.total, response.data);
  }

  void sort(int columnIndex, bool ascending) {
    var columnName = "";
    switch (columnIndex) {
      case 0:
        columnName = "customer";
        break;
      case 1:
        columnName = "class";
        break;
      case 2:
        columnName = "package";
        break;
      case 3:
        columnName = "payment_mode";
        break;
      case 4:
        columnName = "expiry_date";
        break;
      case 5:
        columnName = "subscribed_date";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }
}
