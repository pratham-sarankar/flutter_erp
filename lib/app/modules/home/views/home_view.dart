import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/utils/themes.dart';
import 'package:flutter_erp/widgets/global_widgets/dashboard_widget.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/widgets/payment_chart.dart';
import 'package:flutter_erp/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:flutter_erp/widgets/customers_chart.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget? builder() {
    return ErpScaffold(
      path: Routes.HOME,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          child: ListView(
            children: [
              _dashboardWidgets(controller),
              Row(
                children: [
                  Expanded(
                    flex: 65,
                    child: Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(top: 22),
                        height: 500,
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 15),
                              child: Text(
                                "Monthly Sales",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      screen.context.theme.colorScheme.tertiary,
                                ),
                              ),
                            ),
                            Expanded(
                                child: PaymentChart(
                              data: controller.paymentSummary.value.monthlyData,
                            )),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(top: 22),
                      height: 500,
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 15),
                            child: Text(
                              "Recent Sales",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    screen.context.theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Obx(() {
                              return ListView(
                                children: controller.recentPayments
                                    .map(
                                      (e) => ListTile(
                                          title: Text("${e.customer?.name}"),
                                          subtitle: Text(
                                              "${e.customer?.phoneNumber ?? e.customer?.email}"),
                                          trailing: Text(
                                            "+${e.amount}",
                                            style: TextStyle(
                                              color: screen.context.theme
                                                  .extension<StatsColors>()!
                                                  .increaseColor,
                                            ),
                                          )),
                                    )
                                    .toList(),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 65,
                    child: Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(top: 22),
                        height: 500,
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 15),
                              child: Text(
                                "Customers",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      screen.context.theme.colorScheme.tertiary,
                                ),
                              ),
                            ),
                            Expanded(
                              child: CustomersChart(
                                data: controller
                                    .customerSummary.value.monthlyData,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(top: 22),
                      height: 500,
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 15),
                            child: Text(
                              "Recent Registrations",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    screen.context.theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: controller
                                  .customerSummary.value.recent.length,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  height: 1,
                                );
                              },
                              itemBuilder: (context, index) {
                                final customer = controller
                                    .customerSummary.value.recent[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: screen.context.theme
                                        .extension<StatsColors>()!
                                        .increaseColor,
                                    child: Text(
                                      "P",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text(customer.name),
                                  subtitle: Text(
                                    "developer.pratham@gmail.com",
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashboardWidgets(HomeController controller) {
    var salesWidget = Obx(
      () => DashboardWidget(
        screen: screen,
        title: "Sales",
        data: "₹ ${controller.paymentSummary.value.total}",
        description:
            paymentPercentageWidget(controller.paymentSummary.value.percentage),
      ),
    );
    var customersWidget = Obx(() => DashboardWidget(
              screen: screen,
              title: "Customers",
              data: "${controller.customerSummary.value.total}",
              description: Row(
                children: [
                  Text(
                    "${controller.customerSummary.value.difference}",
                    style: TextStyle(
                      fontSize: screen.isDesktop ? 18 : 16,
                      fontWeight: FontWeight.w600,
                      color: screen.context.theme
                          .extension<StatsColors>()!
                          .increaseColor,
                    ),
                  ),
                ],
              ),
            )
        // description: Row(
        //   children: [
        //     CircleAvatar(
        //       radius: 6,
        //       backgroundColor:
        //           screen.context.theme.extension<MembershipColors>()!.premium,
        //     ),
        //     const SizedBox(width: 4),
        //     Text(
        //       "12",
        //       style: TextStyle(
        //         fontSize: 15,
        //         fontWeight: FontWeight.w600,
        //         color: screen.context.theme.colorScheme.secondary,
        //       ),
        //     ),
        //     const SizedBox(width: 8),
        //     CircleAvatar(
        //       radius: 6,
        //       backgroundColor:
        //           screen.context.theme.extension<MembershipColors>()!.standard,
        //     ),
        //     const SizedBox(width: 4),
        //     Text(
        //       "13",
        //       style: TextStyle(
        //         fontSize: 15,
        //         fontWeight: FontWeight.w600,
        //         color: screen.context.theme.colorScheme.secondary,
        //       ),
        //     ),
        //     const SizedBox(width: 8),
        //     CircleAvatar(
        //       radius: 6,
        //       backgroundColor:
        //           screen.context.theme.extension<MembershipColors>()!.basic,
        //     ),
        //     const SizedBox(width: 4),
        //     Text(
        //       "13",
        //       style: TextStyle(
        //         fontSize: 15,
        //         fontWeight: FontWeight.w600,
        //         color: screen.context.theme.colorScheme.secondary,
        //       ),
        //     ),
        //   ],
        // ),
        );
    var classesCoursesWidget = Obx(
      () => DashboardWidget(
        screen: screen,
        title: "Classes/Courses",
        data:
            "${controller.classSummary.value.total}/${controller.courseSummary.value.total}",
      ),
    );
    var employeesWidget = Obx(
      () => DashboardWidget(
        screen: screen,
        title: "Employees",
        data: "${controller.employeeSummary.value.total}",
      ),
    );
    if (screen.isDesktop) {
      return Row(
        children: [
          Expanded(flex: 20, child: salesWidget),
          const SizedBox(width: 20),
          Expanded(flex: 20, child: customersWidget),
          const SizedBox(width: 20),
          Expanded(flex: 20, child: classesCoursesWidget),
          const SizedBox(width: 20),
          Expanded(flex: 30, child: employeesWidget),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(flex: 20, child: salesWidget),
              const SizedBox(width: 20),
              Expanded(flex: 20, child: customersWidget),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(flex: 20, child: classesCoursesWidget),
              const SizedBox(width: 20),
              Expanded(flex: 20, child: employeesWidget),
            ],
          ),
        ],
      );
    }
  }

  Widget paymentPercentageWidget(num percentage) {
    if (percentage == 0) {
      return Container();
    }
    bool isIncrease = percentage > 0;
    percentage = percentage.abs();
    return Row(
      children: [
        Text(
          "$percentage%",
          style: TextStyle(
            fontSize: screen.isDesktop ? 18 : 16,
            fontWeight: FontWeight.w600,
            color: isIncrease
                ? screen.context.theme.extension<StatsColors>()!.increaseColor
                : screen.context.theme.extension<StatsColors>()!.decreaseColor,
          ),
        ),
        Icon(
          isIncrease ? IconlyLight.arrowUp : IconlyLight.arrowDown,
          size: 18,
          color: isIncrease
              ? screen.context.theme.extension<StatsColors>()!.increaseColor
              : screen.context.theme.extension<StatsColors>()!.decreaseColor,
        )
      ],
    );
  }
}
