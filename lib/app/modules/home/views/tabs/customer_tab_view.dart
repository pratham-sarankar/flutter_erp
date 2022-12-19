import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/home/controllers/customer_controller.dart';
import 'package:get/get.dart';

class CustomerTabView extends GetResponsiveView<CustomerTabController> {
  CustomerTabView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Scaffold(
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
            } else if (!controller.dataSource.hasData) {
              return const Center(child: Text("No Customers"));
            }
            return ListView(
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: PaginatedDataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color:
                                  screen.context.theme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color:
                                  screen.context.theme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Phone Number",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color:
                                  screen.context.theme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Date of Birth",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color:
                                  screen.context.theme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Actions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color:
                                  screen.context.theme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ],
                      rowsPerPage: controller.dataSource.rowsPerPage,
                      header: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "All Customers",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  screen.context.theme.colorScheme.onBackground,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 40),
                            width: 150,
                            child: CupertinoTextField(
                              prefix: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Icon(
                                  CupertinoIcons.search,
                                  size: 18,
                                  color: screen.context.theme.iconTheme.color,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color:
                                    screen.context.theme.colorScheme.secondary,
                              ),
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 8, right: 10),
                              placeholder: "Search",
                              cursorHeight: 16,
                              // onChanged: controller.dataSource.onSearchUpdate,
                              placeholderStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color:
                                    screen.context.theme.colorScheme.tertiary,
                              ),
                              clearButtonMode: OverlayVisibilityMode.never,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Get
                                      .theme.outlinedButtonTheme.style!.side!
                                      .resolve({})!.color,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          if (screen.isDesktop)
                            PopupMenuButton(
                              child: Container(
                                width: 150,
                                height: 34,
                                padding: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Get
                                        .theme.outlinedButtonTheme.style!.side!
                                        .resolve({})!.color,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      "All Groups",
                                      style: TextStyle(
                                        color: screen.context.theme.colorScheme
                                            .secondary,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: screen
                                          .context.theme.colorScheme.secondary,
                                    )
                                  ],
                                ),
                              ),
                              itemBuilder: (context) {
                                return const [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text("Demo"),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: Text("Demo 2"),
                                  ),
                                ];
                              },
                            ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.add,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text(screen.isDesktop ? "New Customer" : "Add"),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                      source: controller.dataSource,
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
