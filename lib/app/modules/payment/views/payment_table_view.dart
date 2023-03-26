import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/payment/views/payment_form_view.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/global_widgets/erp_search_field.dart';
import '../controllers/payment_table_controller.dart';

class PaymentTableView extends GetResponsiveView<PaymentTableController> {
  PaymentTableView({Key? key}) : super(key: key);

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

            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => AdvancedPaginatedDataTable(
                    addEmptyRows: false,
                    header: getHeader(controller),
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
                          "Amount",
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
                          "Description",
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
                          "Customer",
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

  Widget getHeader(PaymentTableController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "All Payment",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.selectedPayment.value.isEmpty) {
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
                            CupertinoIcons.refresh,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Text("Refresh"),
                        ],
                      ),
                      onPressed: () async {
                        controller.refresh();
                      },
                    ),
                    const SizedBox(width: 20),
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
                      onPressed: () async {
                        var result = await Get.dialog(
                          const PaymentFormView(),
                          barrierDismissible: false,
                        );
                        if (result) {
                          controller.refresh();
                        }
                      },
                    ),
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
                        const PaymentFormView(),
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
