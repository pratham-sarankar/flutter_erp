import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/sidebar.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/topbar.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class ErpScaffold extends StatelessWidget {
  const ErpScaffold(
      {Key? key, required this.path, required this.screen, required this.body})
      : super(key: key);
  final String path;
  final ResponsiveScreen screen;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: !screen.isDesktop
          ? Stack(
              children: [
                FocusScope(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: _body(),
                  ),
                ),
                FocusScope(
                  autofocus: true,
                  child: _sideBar(isCollapsed: true),
                ),
              ],
            )
          : Row(
              children: [
                FocusScope(
                  autofocus: true,
                  child: _sideBar(),
                ),
                Expanded(
                  child: FocusScope(
                    child: _body(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _sideBar({bool isCollapsed = false}) {
    return SideBar(
      screen: screen,
      isCollapsed: isCollapsed,
      initialPath: path,
      onSelected: (path) {
        if (Get.currentRoute == path) return;
        Get.toNamed(path);
      },
      sideBarGroups: [
        SideBarGroup(
          title: "ANALYTICS",
          sideBarDestinations: [
            SideBarDestination(
              title: "Home",
              icon: IconlyLight.home,
              boldIcon: IconlyBold.home,
              path: Routes.HOME,
            ),
            SideBarDestination(
              title: "Reports",
              icon: IconlyLight.chart,
              boldIcon: IconlyBold.chart,
              path: '/reports',
            ),
          ],
        ),
        SideBarGroup(
          title: "MAIN MENU",
          sideBarDestinations: [
            SideBarDestination(
              title: "Employees",
              icon: IconlyLight.user2,
              boldIcon: IconlyBold.user2,
              path: Routes.EMPLOYEES,
            ),
            SideBarDestination(
              title: "Customers",
              icon: IconlyLight.user3,
              boldIcon: IconlyBold.user3,
              path: Routes.CUSTOMERS,
            ),
          ],
        ),
        SideBarGroup(
          title: "OTHERS",
          sideBarDestinations: [
            SideBarDestination(
              title: "Settings",
              icon: IconlyLight.setting,
              boldIcon: IconlyBold.setting,
              path: Routes.SETTINGS,
            ),
          ],
        ),
      ],
    );
  }

  Widget _body() {
    return Container(
      color: Colors.white.withOpacity(0.2),
      child: Column(
        children: [
          FocusScope(
            child: TopBar(screen: screen),
          ),
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
