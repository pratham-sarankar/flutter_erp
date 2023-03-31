import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:flutter_erp/app/modules/classes/views/classes_form_view.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrule/rrule.dart';

import '../../../../widgets/dialogs/deletion_dialog.dart';
import '../../../data/models/class.dart';

class ClassesTableController extends GetxController {
  late ClassesDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<int> selectedIds;
  late TextEditingController searchController;

  @override
  void onInit() {
    searchController = TextEditingController();
    source = ClassesDataSource();
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

class ClassesDataSource extends AdvancedDataTableSource<Class> {
  String lastSearchTerm = '';
  String sortingQuery = '';
  bool remoteReload = false;

  RxList<int> get selectedIds => Get.find<ClassesTableController>().selectedIds;

  @override
  DataRow? getRow(int index) {
    var classDetails = lastDetails?.rows[index];
    return DataRow(
      selected: selectedIds.contains(classDetails?.id),
      onLongPress: () {
        selectedRow(classDetails?.id, true);
      },
      onSelectChanged: (value) {
        if (selectedIds.isEmpty) {
          Get.toNamed(Routes.CLASS, parameters: {"id": "${classDetails?.id}"});
        } else {
          selectedRow(classDetails?.id, value ?? false);
        }
      },
      cells: [
        DataCell(Row(
          children: [
            if (classDetails?.getPhotoUrl() != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(classDetails!.getPhotoUrl()!),
                ),
              ),
            Text(
              classDetails?.title ?? "-",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
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
        DataCell(
          Text(
            classDetails?.endTime?.format(Get.context!) ?? "",
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
                    const ClassesFormView(),
                    arguments: classDetails,
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
                        await Get.find<ClassRepository>()
                            .destroy(classDetails!);
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
