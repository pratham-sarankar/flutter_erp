import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:flutter_erp/app/data/utils/extensions/datetime.dart';
import 'package:flutter_erp/app/modules/employees/views/employees_form_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrule/rrule.dart';

import '../../../../widgets/dialogs/deletion_dialog.dart';
import '../../../data/models/course.dart';
import '../../../data/models/employee.dart';

class EmployeesTableController extends GetxController {
  late EmployeesDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<int> selectedIds;
  late TextEditingController searchController;

  @override
  void onInit() {
    searchController = TextEditingController();
    source = EmployeesDataSource();
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
  void insertNew() async {
    var result = await Get.dialog(
      const EmployeesFormView(),
      barrierDismissible: false,
    );
    if (result) {
      refresh();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<void> refresh()async {
    source.refresh();
    super.refresh();
  }


  @override
  void onClose() {
    super.onClose();
  }
}

class EmployeesDataSource extends AdvancedDataTableSource<Employee> {
  String lastSearchTerm = '';
  String sortingQuery = '';
  bool remoteReload = false;

  get selectedIds => Get.find<EmployeesTableController>().selectedIds;

  @override
  DataRow? getRow(int index) {
    var employeeDetails = lastDetails?.rows[index];
    return DataRow(
      selected: selectedIds.contains(employeeDetails?.id),
      onSelectChanged: (value) {
        selectedRow(employeeDetails?.id, value ?? false);
      },
      cells: [
        DataCell(Row(
          children: [
            if (employeeDetails?.getPhotoUrl() != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage:
                      NetworkImage(employeeDetails!.getPhotoUrl()!),
                ),
              ),
            Text(
              employeeDetails?.getName() ?? "-",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
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
          employeeDetails?.getDateOfBirth() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          employeeDetails?.designation?.name ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
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
                    const EmployeesFormView(),
                    arguments: employeeDetails,
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
                        await Get.find<EmployeeRepository>()
                            .destroy(employeeDetails!);
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

  void refresh() {
    setNextView();
    notifyListeners();
  }

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
    return remoteReload;
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
