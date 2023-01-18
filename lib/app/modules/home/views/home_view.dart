import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/utils/themes.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/dashboard_widget.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/data/widgets/payment_chart.dart';
import 'package:flutter_erp/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: DashboardWidget(
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
                    child: DashboardWidget(
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
                    child: DashboardWidget(
                      screen: screen,
                      title: "New/Returning",
                      data: "3/23",
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 30,
                    child: DashboardWidget(
                      screen: screen,
                      title: "Active Members",
                      data: "9",
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 400,
                  margin: const EdgeInsets.only(top: 22),
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
                        child: Text(
                          "Monthly Sales",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: screen.context.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const Expanded(child: PaymentChart()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
