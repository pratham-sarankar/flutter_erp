import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/global_widgets/erp_search_field.dart';
import '../controllers/customer_table_controller.dart';
import 'customer_form_view.dart';

class CustomerTableView extends GetResponsiveView<CustomerTableController> {
  CustomerTableView({Key? key}) : super(key: key);

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
                          "Username",
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
                          "Full Name",
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
                          "Email",
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
                          "Phone Number",
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
                          "Date of Birth",
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

  Widget getHeader(CustomerTableController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "All Customers",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.selectedCustomers.isEmpty) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    ErpSearchField(
                      onUpdate: (query) {
                        controller.source.filterServerSide(query);
                      },
                      controller: controller.searchController,
                    ),
                    const Spacer(),
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
                          const CustomerFormView(),
                          barrierDismissible: false,
                        );
                      },
                    )
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                        const CustomerFormView(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
