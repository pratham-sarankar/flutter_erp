import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrule/rrule.dart';

import '../../../data/models/course.dart';
import '../../../data/models/employee.dart';

class EmployeesTableController extends GetxController {
  late EmployeesDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<Employee> selectedEmployees;
  late TextEditingController searchController;


  @override
  void onInit() {
    searchController = TextEditingController();
    source = EmployeesDataSource();
    rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage.obs;
    sortAscending = true.obs;
    sortColumnIndex = 0.obs;
    selectedEmployees = <Employee>[].obs;
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

class EmployeesDataSource extends AdvancedDataTableSource<Employee> {
  String lastSearchTerm = '';
  String sortingQuery = '';

  get selectedEmployees => Get.find<EmployeesTableController>().selectedEmployees;

  @override
  DataRow? getRow(int index) {
    var employeeDetails = lastDetails?.rows[index];
    return DataRow(
      selected: selectedEmployees.contains(employeeDetails),
      onSelectChanged: (value) {
        selectedRow(employeeDetails, value ?? false);
      },
      cells: [
        DataCell(Text(
          employeeDetails?.getName() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          employeeDetails?.getEmail() ?? "",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          employeeDetails?.getPhoneNumber() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          employeeDetails?.dob?.timeZoneName?? "-",

          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          employeeDetails?.designation?.name?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
      ],
    );
  }

  @override
  int get selectedRowCount => selectedEmployees.length;

  void selectedRow(Employee? employeeDetails, bool newSelectState) {
    if (selectedEmployees.contains(employeeDetails)) {
      selectedEmployees.remove(employeeDetails);
    } else {
      selectedEmployees.add(employeeDetails);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<Employee>> getNextPage(
      NextPageRequest pageRequest) async {
    var response = await Get.find<EmployeeRepository>().fetchWithCount(
      offset: pageRequest.offset,
      limit: pageRequest.pageSize,
      queries: {
        "search": lastSearchTerm,
        "order": sortingQuery,
      },
    );
    // print(response.data);
    return RemoteDataSourceDetails(
      response.total,
      response.data,
      filteredRows: lastSearchTerm.isEmpty ? null : response.data.length,
    );
  }


  @override
  void setNextView({int startIndex = 0}) {
    selectedEmployees.value = <Employee>[];
    super.setNextView(startIndex: startIndex);
  }

  @override
  bool requireRemoteReload() {
    if(lastSearchTerm.isNotEmpty){
      return selectedEmployees.value.isEmpty;
    }
    return lastDetails?.filteredRows!=null;
  }


  void sort(int columnIndex, bool ascending) {
    var columnName = "";
    switch (columnIndex) {
      case 0:
        columnName = "full_name";
        break;
      case 1:
        columnName = "email";
        break;
      case 3:
        columnName = "phone_number";
        break;
      case 4:
        columnName = "Date_of_birth";
        break;
      case 5:
        columnName = "designation";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }
}
