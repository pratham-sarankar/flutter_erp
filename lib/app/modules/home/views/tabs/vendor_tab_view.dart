import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/utils/themes.dart';
import 'package:flutter_erp/app/modules/home/controllers/vendor_controller.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class VendorTabView extends GetResponsiveView<VendorTabController> {
  VendorTabView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Scaffold(
      backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
      body: FocusScope(
        child: Container(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: ListView(
            padding: const EdgeInsets.only(top: 22),
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: _CustomerDashboardWidget(
                      screen: screen,
                      title: "Total",
                      data: "124",
                      description: Row(
                        children: [
                          Text(
                            "4%",
                            style: TextStyle(
                              fontSize: screen.isDesktop ? 18 : 16,
                              fontWeight: FontWeight.w600,
                              color: screen.context.theme
                                  .extension<StatsColors>()!
                                  .decreaseColor,
                            ),
                          ),
                          Icon(
                            IconlyLight.arrowDown,
                            size: 18,
                            color: screen.context.theme
                                .extension<StatsColors>()!
                                .decreaseColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 20,
                    child: _CustomerDashboardWidget(
                      screen: screen,
                      title: "Members",
                      data: "65",
                      description: screen.isDesktop
                          ? Row(
                              children: [
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: screen.context.theme
                                      .extension<MembershipColors>()!
                                      .premium,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "12",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: screen
                                        .context.theme.colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: screen.context.theme
                                      .extension<MembershipColors>()!
                                      .standard,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "13",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: screen
                                        .context.theme.colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: screen.context.theme
                                      .extension<MembershipColors>()!
                                      .basic,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "13",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: screen
                                        .context.theme.colorScheme.secondary,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 20,
                    child: _CustomerDashboardWidget(
                      screen: screen,
                      title: "New/Returning",
                      data: "3/23",
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 30,
                    child: _CustomerDashboardWidget(
                      screen: screen,
                      title: "Active Members",
                      data: "9",
                    ),
                  ),
                ],
              ),
              LayoutBuilder(builder: (context, constraints) {
                return Container(
                  margin: const EdgeInsets.only(top: 22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: screen.context.theme.colorScheme.background,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () {
                          if (controller.dataSource.value.vendors.isEmpty) {
                            return Container(
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth,
                              ),
                              height: Get.height * 0.7,
                              child: Center(
                                child: TextButton(
                                  child: const Text("Add Vendors"),
                                  onPressed: () {
                                    controller.dataSource.value.addVendor();
                                  },
                                ),
                              ),
                            );
                          }
                          return Container(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            child: PaginatedDataTable(
                              rowsPerPage:
                                  controller.dataSource.value.rowsPerPage,
                              source: controller.dataSource.value,
                              sortColumnIndex:
                                  controller.dataSource.value.sortIndex,
                              sortAscending:
                                  controller.dataSource.value.ascending,
                              arrowHeadColor:
                                  context.theme.colorScheme.onBackground,
                              header: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "All Vendors",
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
                                        padding: const EdgeInsets.only(left: 8),
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
                                        color: screen.context.theme.colorScheme
                                            .secondary,
                                      ),
                                      padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          left: 8,
                                          right: 10),
                                      placeholder: "Search",
                                      cursorHeight: 16,
                                      onChanged: controller
                                          .dataSource.value.onSearchUpdate,
                                      placeholderStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: screen
                                            .context.theme.colorScheme.tertiary,
                                      ),
                                      clearButtonMode:
                                          OverlayVisibilityMode.never,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Get.theme.outlinedButtonTheme
                                              .style!.side!
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
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Get.theme.outlinedButtonTheme
                                                .style!.side!
                                                .resolve({})!.color,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              "All Vendors",
                                              style: TextStyle(
                                                color: screen.context.theme
                                                    .colorScheme.secondary,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(
                                              Icons.arrow_drop_down_rounded,
                                              color: screen.context.theme
                                                  .colorScheme.secondary,
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
                                    children: const [
                                      Icon(
                                        CupertinoIcons.square_arrow_right,
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      Text("Export"),
                                    ],
                                  ),
                                  onPressed: () {
                                    controller.dataSource.value.addVendor();
                                  },
                                ),
                                TextButton(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.add,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(screen.isDesktop
                                          ? "New Customer"
                                          : "Add"),
                                    ],
                                  ),
                                  onPressed: () {
                                    controller.dataSource.value.addVendor();
                                  },
                                ),
                              ],
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: screen.context.theme.colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                  onSort: (columnIndex, ascending) {
                                    controller.dataSource.value.setSortIndex =
                                        columnIndex;
                                    controller.dataSource.value.setAscending =
                                        ascending;
                                    controller.dataSource.value.sortByName();
                                  },
                                ),
                                DataColumn(
                                  label: Text(
                                    'Mobile no.',
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
                                    'Email',
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
                                    'GSTIN',
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
                              dataRowHeight: 60,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomerDashboardWidget extends StatelessWidget {
  const _CustomerDashboardWidget({
    required this.screen,
    required this.title,
    required this.data,
    this.description,
  });
  final ResponsiveScreen screen;
  final String title;
  final String data;
  final Widget? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: screen.context.theme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 100,
      padding: EdgeInsets.only(
        top: 12,
        bottom: 16,
        right: Get.width * 0.015,
        left: Get.width * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: screen.context.theme.colorScheme.tertiary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data,
                style: TextStyle(
                  fontSize: screen.isDesktop ? 26 : 22,
                  fontWeight: FontWeight.w700,
                  height: screen.isDesktop ? 0.6 : 1,
                  color: screen.context.theme.colorScheme.secondary,
                ),
              ),
              screen.isDesktop ? description ?? Container() : Container(),
            ],
          )
        ],
      ),
    );
  }
}
