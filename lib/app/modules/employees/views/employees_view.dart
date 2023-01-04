import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/data/widgets/plus_widgets/plus_dropdown.dart';
import 'package:flutter_erp/app/modules/employees/controllers/employees_controller.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class EmployeesView extends GetResponsiveView<EmployeesController> {
  EmployeesView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.EMPLOYEES,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Container(
          margin: const EdgeInsets.only(right: 16, left: 16, top: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (!controller.dataSource.value.hasData) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.createNewEmployee();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(CupertinoIcons.add, size: 18),
                        SizedBox(width: 5),
                        Text("Add Employee"),
                      ],
                    ),
                  ),
                );
              }
              return ListView(
                shrinkWrap: true,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        constraints:
                            BoxConstraints(minWidth: constraints.minWidth),
                        child: !controller.dataSource.value.hasData
                            ? Container()
                            : PaginatedDataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      "Name",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: screen.context.theme.colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: screen.context.theme.colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: screen.context.theme.colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Designation",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: screen.context.theme.colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Actions',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: screen.context.theme.colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                ],
                                rowsPerPage:
                                    controller.dataSource.value.rowsPerPage,
                                header: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "All Employees",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: screen.context.theme.colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 40),
                                      width: 150,
                                      child: CupertinoTextField(
                                        prefix: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Icon(
                                            CupertinoIcons.search,
                                            size: 18,
                                            color: screen
                                                .context.theme.iconTheme.color,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: screen.context.theme
                                              .colorScheme.secondary,
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                            left: 8,
                                            right: 10),
                                        placeholder: "Search",
                                        cursorHeight: 16,
                                        // onChanged: controller.dataSource.onSearchUpdate,
                                        placeholderStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: screen.context.theme
                                              .colorScheme.tertiary,
                                        ),
                                        clearButtonMode:
                                            OverlayVisibilityMode.never,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: screen
                                                .context
                                                .theme
                                                .outlinedButtonTheme
                                                .style!
                                                .side!
                                                .resolve({})!.color,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    if (screen.isDesktop)
                                      PlusDropDown(
                                        initialValue: null,
                                        items: [
                                          DropdownMenuItem<int>(
                                            value: null,
                                            child: Text(
                                              "All Designations",
                                              style: TextStyle(
                                                color: context.theme.colorScheme
                                                    .secondary,
                                                fontSize: 15,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          ...controller.designations
                                              .map(
                                                (designation) =>
                                                    DropdownMenuItem<int>(
                                                  enabled:
                                                      designation.hasEmployees,
                                                  value: designation.id,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        designation.getName(),
                                                        style: TextStyle(
                                                            color: designation.hasEmployees
                                                                ? context
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary
                                                                : Colors.grey
                                                                    .shade400,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList()
                                        ],
                                        onChanged: (id) async {
                                          controller.sortByDesignation(id);
                                        },
                                      ),
                                  ],
                                ),
                                actions: [
                                  Obx(
                                    () => !controller.isSelectionMode.value
                                        ? TextButton(
                                            child: Row(
                                              children: controller
                                                      .isRefreshing.value
                                                  ? [
                                                      const SizedBox(
                                                        height: 15,
                                                        width: 15,
                                                        child:
                                                            CircularProgressIndicator(
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
                                            onPressed: () {
                                              controller.refresh();
                                            },
                                          )
                                        : Container(),
                                  ),
                                  Obx(
                                    () => controller.isSelectionMode.value
                                        ? TextButton(
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  CupertinoIcons.delete,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 5),
                                                Text("Delete All"),
                                              ],
                                            ),
                                            onPressed: () {
                                              controller
                                                  .deleteSelectedEmployees();
                                            },
                                          )
                                        : Container(),
                                  ),
                                  Obx(
                                    () => !controller.isSelectionMode.value
                                        ? TextButton(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.add,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  screen.isDesktop
                                                      ? "New Employee"
                                                      : "Add",
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              controller.createNewEmployee();
                                            },
                                          )
                                        : Container(),
                                  ),
                                ],
                                source: controller.dataSource.value,
                              ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
