import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrule/rrule.dart';

import '../../../data/models/course.dart';

class CoursesTableController extends GetxController {
  late CoursesDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<Course> selectedCourses;
  late TextEditingController searchController;

  @override
  void onInit() {
    searchController = TextEditingController();
    source = CoursesDataSource();
    rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage.obs;
    sortAscending = true.obs;
    sortColumnIndex = 0.obs;
    selectedCourses = <Course>[].obs;
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

class CoursesDataSource extends AdvancedDataTableSource<Course> {
  String lastSearchTerm = '';
  String sortingQuery = '';

  get selectedCourses => Get.find<CoursesTableController>().selectedCourses;

  @override
  DataRow? getRow(int index) {
    var courseDetails = lastDetails?.rows[index];
    return DataRow(
      selected: selectedCourses.contains(courseDetails),
      onSelectChanged: (value) {
        selectedRow(courseDetails, value ?? false);
      },
      cells: [
        DataCell(Text(
          courseDetails?.title ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          courseDetails?.description ?? "",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          courseDetails?.duration.toString() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
      ],
    );
  }

  @override
  int get selectedRowCount => selectedCourses.length;

  void selectedRow(Course? courseDetails, bool newSelectState) {
    if (selectedCourses.contains(courseDetails)) {
      selectedCourses.remove(courseDetails);
    } else {
      selectedCourses.add(courseDetails);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
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
      filteredRows: lastSearchTerm.isEmpty ? null : response.data.length,
    );
  }
  @override
  void setNextView({int startIndex = 0}) {
    selectedCourses.value = <Course>[];
    super.setNextView(startIndex: startIndex);
  }

  @override
  bool requireRemoteReload() {
    if(lastSearchTerm.isNotEmpty){
      return selectedCourses.value.isEmpty;
    }
    return lastDetails?.filteredRows!=null;
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
      case 3:
        columnName = "duration";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }
}
