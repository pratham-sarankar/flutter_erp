import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/models/purchase.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/modules/customers/views/customer_form_view.dart';
import 'package:flutter_erp/app/modules/purchases/views/purchase_form_view.dart';
import 'package:flutter_erp/app/modules/subscriptions/views/subscription_form_view.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/dialogs/deletion_dialog.dart';

class CustomerTableController extends GetxController {
  late CustomersDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;
  late RxList<int> selectedIds;
  late TextEditingController searchController;

  @override
  void onInit() {
    searchController = TextEditingController();
    source = CustomersDataSource();
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
      const CustomerFormView(),
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

class CustomersDataSource extends AdvancedDataTableSource<Customer> {
  String lastSearchTerm = '';
  String sortingQuery = '';
  bool remoteReload = false;

  RxList<int> get selectedIds =>
      Get.find<CustomerTableController>().selectedIds;

  @override
  DataRow? getRow(int index) {
    var customer = lastDetails?.rows[index];
    return DataRow(
      selected: selectedIds.contains(customer?.id),
      onSelectChanged: (value) {
        selectedRow(customer?.id, value ?? false);
      },
      cells: [
        DataCell(Row(
          children: [
            if (customer?.getPhotoUrl() != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(customer!.getPhotoUrl()!),
                ),
              ),
            Text(
              customer?.username ?? "-",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )),
        DataCell(Text(
          customer?.name ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          customer?.getEmail() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          customer?.phoneNumber ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          customer?.getDateOfBirth() ?? "",
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
                case "add_subscription":
                  var result = await Get.dialog(
                    const SubscriptionFormView(),
                    arguments: Subscription(
                      customer: customer,
                      customerId: customer?.id,
                      branchId: Get.find<AuthService>().currentBranch.id,
                    ),
                    barrierDismissible: false,
                  );
                  if (result) {
                    refresh();
                    Get.find<ToastService>()
                        .showSuccessToast("Subscription added successfully.");
                  }
                  break;
                case "add_purchase":
                  var result = await Get.dialog(
                    const PurchaseFormView(),
                    arguments: Purchase(
                      customer: customer,
                      customerId: customer?.id,
                      branchId: Get.find<AuthService>().currentBranch.id,
                    ),
                    barrierDismissible: false,
                  );
                  if (result) {
                    refresh();
                    Get.find<ToastService>()
                        .showSuccessToast("Purchase added successfully.");
                  }
                  break;
                case "edit":
                  var result = await Get.dialog(
                    const CustomerFormView(),
                    arguments: customer,
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
                        await Get.find<CustomerRepository>().destroy(customer!);
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
                  value: "add_subscription",
                  height: 35,
                  child: Row(
                    children: const [
                      Icon(
                        CupertinoIcons.add,
                        size: 18,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Add Subscription",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(height: 1),
                PopupMenuItem(
                  value: "add_purchase",
                  height: 35,
                  child: Row(
                    children: const [
                      Icon(
                        IconlyLight.buy,
                        size: 18,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Add Purchase",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(height: 1),
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
  bool get forceRemoteReload => true;

  @override
  int get selectedRowCount =>
      Get.find<CustomerTableController>().selectedIds.length;

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
  Future<RemoteDataSourceDetails<Customer>> getNextPage(
      NextPageRequest pageRequest) async {
    var response = await Get.find<CustomerRepository>().fetchWithCount(
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
        columnName = "username";
        break;
      case 1:
        columnName = "full_name";
        break;
      case 2:
        columnName = "email";
        break;
      case 3:
        columnName = "phone_number";
        break;
      case 4:
        columnName = "date_of_birth";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }
}
