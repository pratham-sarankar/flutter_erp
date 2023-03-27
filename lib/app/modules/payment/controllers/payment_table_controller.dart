import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:flutter_erp/app/modules/payment/controllers/payment_form_controller.dart';
import 'package:flutter_erp/app/modules/payment/views/payment_form_view.dart';
import 'package:flutter_erp/widgets/dialogs/deletion_dialog.dart';
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
        DataCell(
          Text(
            paymentDetails?.amount?.toString() ?? "-",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(Text(
          paymentDetails?.description ?? "",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(
          Text(
            paymentDetails?.customer?.name ?? "-",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 10,
            offset: const Offset(0, 20),
            onSelected: (value) async {
              switch (value) {
                case "edit":
                  var result = await Get.dialog(
                    const PaymentFormView(),
                    arguments: paymentDetails,
                    barrierDismissible: false,
                  );
                  if (result) {
                    refresh();
                  }
                  break;
                case "delete":
                  var result = await Get.dialog(
                    DeletionDialog(
                      onDelete: () async {
                        await Get.find<PaymentRepository>()
                            .destroy(paymentDetails!);
                        return true;
                      },
                    ),
                  );
                  if (result) {
                    refresh();
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  value: "edit",
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
                  value: "delete",
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
            padding: EdgeInsets.zero,
            child: const Icon(Icons.more_vert, color: Colors.black, size: 22),
          ),
        ),
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
