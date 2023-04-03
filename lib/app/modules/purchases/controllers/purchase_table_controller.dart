import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/discount.dart';
import 'package:flutter_erp/app/data/models/purchase.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/purchase_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/modules/purchases/views/purchase_form_view.dart';
import 'package:flutter_erp/app/modules/subscriptions/views/subscription_form_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseTableController extends GetxController {
  late PurchaseDataSource source;
  late RxInt rowsPerPage;
  late RxBool sortAscending;
  late RxInt sortColumnIndex;

  @override
  void onInit() {
    source = PurchaseDataSource();
    rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage.obs;
    sortAscending = true.obs;
    sortColumnIndex = 0.obs;
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
      const PurchaseFormView(),
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

class PurchaseDataSource extends AdvancedDataTableSource<Purchase> {
  String lastSearchTerm = '';
  String sortingQuery = '';

  void refresh() {
    setNextView();
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    var purchase = lastDetails?.rows[index];
    return DataRow(
      cells: [
        DataCell(
          Text(
            purchase?.customer?.name ?? "",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DataCell(Text(
          purchase?.course?.title ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          purchase?.payment?.mode?.title ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(
          discountWidget(
            purchase?.discount ?? Discount(type: DiscountType.none, value: 0),
          ),
        ),
        DataCell(Text(
          purchase?.getPurchasedAt() ?? "-",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
      ],
    );
  }

  Widget discountWidget(Discount discount) {
    switch (discount.type) {
      case DiscountType.price:
        return Text(
          "Rs ${discount.value}",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        );
      case DiscountType.percentage:
        return Text(
          "${discount.value}%",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        );
      default:
        return Text(
          DiscountType.none.title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        );
    }
  }

  @override
  bool get forceRemoteReload => true;

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<Purchase>> getNextPage(
      NextPageRequest pageRequest) async {
    var response = await Get.find<PurchaseRepository>().fetchWithCount(
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
      filteredRows: lastSearchTerm.isNotEmpty ? response.data.length : null,
    );
  }

  void sort(int columnIndex, bool ascending) {
    var columnName = "";
    switch (columnIndex) {
      case 0:
        columnName = "customer";
        break;
      case 1:
        columnName = "class";
        break;
      case 2:
        columnName = "payment_mode";
        break;
      case 3:
        columnName = "discount";
        break;
      case 4:
        columnName = "purchase_date";
        break;
    }
    sortingQuery = "$columnName&DESC=${!ascending}";
    setNextView();
  }

  @override
  int get selectedRowCount => 0;
}
