import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/utils/abstracts/repository.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/columns/table_column.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/resource.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/row/cell.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/row/resource_row.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TableView<T extends Resource> extends StatelessWidget {
  const TableView({
    Key? key,
    required this.repository,
    this.title = "All Data",
    this.onUpdate,
    this.onCreate,
    this.onDelete,
  }) : super(key: key);
  final Repository<T> repository;
  final String title;
  final Future<T> Function()? onCreate;
  final Future<T?> Function(T)? onUpdate;
  final Future<bool> Function(T)? onDelete;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TableController<T>>(
      id: repository.hashCode,
      init: TableController(
        repository,
        onCreateRow: onCreate,
        onDeleteRow: onDelete,
        onUpdateRow: onUpdate,
      ),
      builder: (controller) {
        return controller.obx(
          (state) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  getHeader(controller),
                  Expanded(
                    child: ListView(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            showCheckboxColumn: false,
                            showBottomBorder: true,
                            onSelectAll: (value) {},
                            columns: [
                              DataColumn(
                                label: Text(
                                  "S. no.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              for (String data in controller.column.columns)
                                DataColumn(
                                  label: Text(
                                    data,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                            rows: [
                              for (int i = 0; i < controller.rows.length; i++)
                                getDataRow(controller.rows, i),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  getFooter(controller),
                ],
              ),
            );
          },
          onLoading: const Center(
            child: CircularProgressIndicator(),
          ),
          onEmpty: const Center(
            child: Text("No data"),
          ),
          onError: (error) {
            return Center(
              child: Text(error.toString()),
            );
          },
        );
      },
    );
  }

  Widget getHeader(TableController controller) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 18, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          TextButton(
            child: Obx(
              () => Row(
                children: controller.isRefreshing.value
                    ? [
                        const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                            strokeWidth: 2,
                          ),
                        ),
                      ]
                    : const [
                        Icon(
                          CupertinoIcons.refresh,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text("Refresh"),
                      ],
              ),
            ),
            onPressed: () {
              controller.reload();
            },
          ),
          if (onCreate != null)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextButton(
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
                  controller.insertRow();
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget getFooter(TableController controller) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios, size: 14),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios, size: 14),
          ),
        ],
      ),
    );
  }

  DataRow getDataRow(List<ResourceRow> rows, int index) {
    return DataRow(
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              (index + 1).toString(),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        for (Cell cell in rows[index].cells)
          DataCell(
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: getCell(cell),
                ),
                for (Cell child in cell.children)
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: getCell(child),
                  )
              ],
            ),
          ),
      ],
    );
  }

  Widget getCell(Cell cell) {
    if (cell.data == null) return Container();
    if (cell.isAction) {
      return TextButton(
        onPressed: cell.onPressed,
        child: Row(
          children: [
            Icon(
              cell.icon,
              size: 14,
            ),
            const SizedBox(width: 5),
            Text(
              cell.data ?? "",
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      );
    }
    if (cell.data?.startsWith("http://") ?? false) {
      return CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(cell.data?.trim() ?? ""),
      );
    }
    return Text(
      cell.data ?? "",
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class TableController<T extends Resource> extends GetxController
    with StateMixin<List<T>> {
  final Repository<T> repository;
  final Future<T> Function()? onCreateRow;
  final Future<T?> Function(T)? onUpdateRow;
  final Future<bool> Function(T)? onDeleteRow;

  TableController(
    this.repository, {
    required this.onCreateRow,
    required this.onUpdateRow,
    required this.onDeleteRow,
  });

  late int limit;
  late int offset;
  late RxBool isRefreshing;

  @override
  void onInit() {
    super.onInit();
    limit = 50;
    offset = 0;
    isRefreshing = false.obs;
    change([], status: RxStatus.loading());
    init();
  }

  List<ResourceRow> get rows =>
      value?.map((e) => e.getResourceRow(this)).toList() ?? [ResourceRow.empty];

  ResourceColumn get column =>
      value?.first.getResourceColumn() ?? ResourceColumn.empty;

  void init() async {
    List<T> values = await repository.fetch(limit: limit, offset: offset);
    change(values,
        status: values.isEmpty ? RxStatus.empty() : RxStatus.success());
  }

  void insertRow() async {
    T? value = await onCreateRow!();
    isRefreshing.value = true;
    await repository.insert(value);
    isRefreshing.value = false;
    await reload();
  }

  void destroyRow(T value) async {
    if (onDeleteRow == null) return;
    bool sure = await onDeleteRow!(value);
    if (!sure) return;
    isRefreshing.value = true;
    await repository.destroy(value);
    isRefreshing.value = false;
    await reload();
  }

  void updateRow(T value) async {
    if (onUpdateRow == null) return;
    T? updatedValue = await onUpdateRow!(value);
    if (updatedValue == null) return;
    isRefreshing.value = true;
    await repository.update(updatedValue);
    isRefreshing.value = false;
    await reload();
  }

  Future reload() async {
    isRefreshing.value = true;
    List<T> values = await repository.fetch(limit: limit, offset: offset);
    isRefreshing.value = false;
    change(values,
        status: values.isEmpty ? RxStatus.empty() : RxStatus.success());
  }
}
