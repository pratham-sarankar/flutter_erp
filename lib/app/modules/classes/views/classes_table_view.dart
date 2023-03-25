import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/global_widgets/erp_search_field.dart';
import '../controllers/classes_table_controller.dart';
import 'classes_form_view.dart';

class ClassesTableView extends GetResponsiveView<ClassesTableController> {
  ClassesTableView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Scaffold(
      backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
      body: Card(
        margin: const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            getHeader(controller),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                      () => AdvancedPaginatedDataTable(
                    addEmptyRows: false,
                    source: controller.source,
                    showFirstLastButtons: true,
                    rowsPerPage: controller.rowsPerPage.value,
                    availableRowsPerPage: const [2, 10, 40, 50, 100],
                    onRowsPerPageChanged: (newRowsPerPage) {
                      controller.setRowPerPage(newRowsPerPage);
                    },
                    sortAscending: controller.sortAscending.value,
                    sortColumnIndex: controller.sortColumnIndex.value,
                    columns: [
                      DataColumn(
                        onSort: controller.sort,
                        label: Text(
                          "Title",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DataColumn(
                        onSort: controller.sort,
                        label: Text(
                          "Trainer",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DataColumn(
                        // onSort: controller.sort,
                        label: Text(
                          "Schedule",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DataColumn(
                        onSort: controller.sort,
                        label: Text(
                          "Start at",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DataColumn(
                        onSort: controller.sort,
                        label: Text(
                          "Ends at",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                    loadingWidget: () => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeader(ClassesTableController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "All Classes",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 28,),
          ErpSearchField(
            onUpdate: (query) {
              controller.source.filterServerSide(query);
            },
          ),
          const Spacer(),
          Obx(() {
            if (controller.selectedClasses.value.isEmpty) {
              return Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.add,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text("Add new"),
                      ],
                    ),
                    onPressed: () {
                      Get.dialog(
                        const ClassesFormView(),
                        barrierDismissible: false,
                      );
                    },
                  )
                ],
              );
            }
            return Row(
              children: [
                TextButton(
                  child: Row(
                    children: const [
                      Icon(
                        CupertinoIcons.delete,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text("Delete"),
                    ],
                  ),
                  onPressed: () {
                    Get.dialog(
                      const ClassesFormView(),
                      barrierDismissible: false,
                    );
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
