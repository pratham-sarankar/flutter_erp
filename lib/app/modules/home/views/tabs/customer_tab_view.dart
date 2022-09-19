import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customers.dart';
import 'package:flutter_erp/app/data/utils/extensions/datetime.dart';
import 'package:flutter_erp/app/data/utils/themes.dart';
import 'package:flutter_erp/app/modules/home/controllers/customer_controller.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';

class CustomersTabView extends GetResponsiveView<CustomerTabController> {
  CustomersTabView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Scaffold(
      body: Container(
        color: screen.context.theme.colorScheme.surfaceVariant,
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: ListView(
          padding: const EdgeInsets.only(top: 22),
          children: [
            Row(
              children: [
                Expanded(
                  flex: 20,
                  child: _CustomerDataTile(
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
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 20,
                  child: _CustomerDataTile(
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
                  child: _CustomerDataTile(
                    screen: screen,
                    title: "New/Returning",
                    data: "3/23",
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 30,
                  child: _CustomerDataTile(
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
                  color: screen.context.theme.backgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 25,
                        right: 25,
                        bottom: 5,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "All Customers",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: screen.context.theme.colorScheme.secondary,
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
                                      .context.theme.primaryIconTheme.color,
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
                          if (screen.isDesktop)
                            PopupMenuButton(
                              child: Container(
                                width: 150,
                                height: 34,
                                margin: const EdgeInsets.only(left: 15),
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
                                      "All Members",
                                      style: TextStyle(
                                        color: screen.context.theme.colorScheme
                                            .secondary,
                                        height: 1.8,
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
                          const Spacer(),
                          if (screen.isDesktop)
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
                              onPressed: () {},
                            ),
                          const SizedBox(width: 15),
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
                      ),
                    ),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return Container();
                        }
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            child: DataTable(
                              sortAscending: true,
                              columns: const [
                                DataColumn(
                                  label: Text('Name'),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Since'),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Membership'),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Total Transactions'),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Total Visits'),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Actions'),
                                  numeric: false,
                                ),
                              ],
                              dataRowHeight: 60,
                              dataTextStyle: TextStyle(
                                color:
                                    screen.context.theme.colorScheme.secondary,
                                fontSize: 14,
                              ),
                              headingTextStyle: TextStyle(
                                color:
                                    screen.context.theme.colorScheme.secondary,
                                fontSize: 16,
                              ),
                              rows: controller.customers
                                  .map(
                                    (Customer customer) => DataRow(
                                      color: MaterialStateProperty.resolveWith<
                                          Color?>(
                                        (Set<MaterialState> states) {
                                          return screen
                                              .context.theme.backgroundColor;
                                        },
                                      ),
                                      cells: <DataCell>[
                                        DataCell(
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    customer.photoURL),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(customer.name),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Text(customer.memberSince
                                              .format("MMM dd, yyyy")),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 15),
                                            child: const Text("Gold"),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "₹${customer.totalPurchased.toString()}",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            customer.totalVisits.toString(),
                                          ),
                                        ),
                                        DataCell(Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.phone_rounded,
                                                    size: 14,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Call",
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            TextButton(
                                              onPressed: () {},
                                              style: const ButtonStyle(
                                                padding:
                                                    MaterialStatePropertyAll(
                                                  EdgeInsets.zero,
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.more_horiz,
                                                size: 15,
                                              ),
                                            )
                                          ],
                                        )),
                                      ],
                                      selected: controller.selectedList[
                                          controller.customers
                                              .indexOf(customer)],
                                      onSelectChanged: (bool? value) {
                                        controller.selectedList[controller
                                            .customers
                                            .indexOf(customer)] = value!;
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
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
    );
  }
}

class _CustomerDataTile extends StatelessWidget {
  const _CustomerDataTile({
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
        color: screen.context.theme.backgroundColor,
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
