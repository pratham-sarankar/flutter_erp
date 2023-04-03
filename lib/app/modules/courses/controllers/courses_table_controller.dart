import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/modules/courses/controllers/courses_from_controller.dart';
import 'package:flutter_erp/app/modules/courses/views/courses_from_view.dart';
import 'package:flutter_erp/app/modules/courses/views/courses_table_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/dialogs/deletion_dialog.dart';
import '../../../data/models/course.dart';

class CoursesTableController extends GetxController {
  late CoursesDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<int> selectedIds;
  late TextEditingController searchController;

  @override
  void onInit() {
    searchController = TextEditingController();
    source = CoursesDataSource();
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
      const CoursesFormView(),
      barrierDismissible: false,
    );
    if (result) {
      refresh();
    }
  }

  @override
  Future<void> refresh() async {
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

class CoursesDataSource extends AdvancedDataTableSource<Course> {
  String lastSearchTerm = '';
  String sortingQuery = '';
  bool remoteReload = false;

  RxList<int> get selectedIds => Get.find<CoursesTableController>().selectedIds;

  @override
  DataRow? getRow(int index) {
    var courseDetails = lastDetails?.rows[index];
    return DataRow(
      selected: selectedIds.contains(courseDetails?.id),
      onSelectChanged: (value) {
        selectedRow(courseDetails?.id, value ?? false);
      },
      cells: [
        DataCell(
          Row(
            children: [
              if (courseDetails?.getPhotoUrl() != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        NetworkImage(courseDetails!.getPhotoUrl()!),
                  ),
                ),
              Text(
                courseDetails?.title ?? "-",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(
          courseDetails?.description ?? "",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          courseDetails?.batchNo?.toString() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(
          Text(
            courseDetails?.duration.toString() ?? "-",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            courseDetails?.getFormattedStartingDate() ?? "-",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(
          Text(
            courseDetails?.price?.toString() ?? "-",
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
                    const CoursesFormView(),
                    arguments: courseDetails,
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
                        await Get.find<CourseRepository>()
                            .destroy(courseDetails!);
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
  Future<RemoteDataSourceDetails<Course>> getNextPage(
      NextPageRequest pageRequest) async {
    var response = await Get.find<CourseRepository>().fetchWithCount(
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
        columnName = "title";
        break;
      case 1:
        columnName = "description";
        break;
      case 2:
        columnName = "description";
        break;
      case 3:
        columnName = "duration";
        break;
      case 4:
        columnName = "starting_date";
        break;
      case 5:
        columnName = "price";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }
}
