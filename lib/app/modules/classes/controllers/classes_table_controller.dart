import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrule/rrule.dart';

import '../../../data/models/class.dart';

class ClassesTableController extends GetxController {
  late ClassesDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<Class> selectedClasses;

  @override
  void onInit() {
    source = ClassesDataSource();
    rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage.obs;
    sortAscending = true.obs;
    sortColumnIndex = 0.obs;
    selectedClasses = <Class>[].obs;
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

class ClassesDataSource extends AdvancedDataTableSource<Class> {
  String lastSearchTerm = '';
  String sortingQuery = '';

  get selectedClasses => Get.find<ClassesTableController>().selectedClasses;

  @override
  DataRow? getRow(int index) {
    var classDetails = lastDetails?.rows[index];
    return DataRow(
      selected: selectedClasses.contains(classDetails),
      onSelectChanged: (value) {
        selectedRow(classDetails, value ?? false);
      },
      cells: [
        DataCell(Text(
          classDetails?.title ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          classDetails?.trainer?.name ?? "",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          classDetails?.schedule == null
              ? "-"
              : Get.find<RRuleService>()
                  .generateReadableText(classDetails!.schedule!),
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          classDetails?.startTime?.format(Get.context!) ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          classDetails?.endTime?.format(Get.context!) ?? "",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
      ],
    );
  }

  @override
  int get selectedRowCount => selectedClasses.length;

  void selectedRow(Class? classDetails, bool newSelectState) {
    if (selectedClasses.contains(classDetails)) {
      selectedClasses.remove(classDetails);
    } else {
      selectedClasses.add(classDetails);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<Class>> getNextPage(
      NextPageRequest pageRequest) async {
    var response = await Get.find<ClassRepository>().fetchWithCount(
      offset: pageRequest.offset,
      limit: pageRequest.pageSize,
      queries: {
        "search": lastSearchTerm,
        "order": sortingQuery,
      },
    );
    print(response.data);
    return RemoteDataSourceDetails(
      response.total,
      response.data,
      filteredRows: lastSearchTerm.isEmpty ? null : response.data.length,
    );
  }

  void sort(int columnIndex, bool ascending) {
    var columnName = "";
    switch (columnIndex) {
      case 0:
        columnName = "title";
        break;
      case 1:
        columnName = "trainer";
        break;
      case 3:
        columnName = "start_at";
        break;
      case 4:
        columnName = "end_at";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }
}
