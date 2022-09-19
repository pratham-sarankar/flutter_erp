import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_erp/app/modules/home/widgets/sidebar.dart';
import 'package:flutter_erp/app/modules/home/widgets/topbar.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget? builder() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: screen.isTablet
          ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: _body(),
                ),
                _sideBar(isCollapsed: true),
              ],
            )
          : Row(
              children: [
                _sideBar(),
                Expanded(
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                    child: Column(
                      children: [
                        TopBar(
                          screen: screen,
                        ),
                        Obx(() {
                          return Expanded(
                            child: IndexedStack(
                              index: controller.tabIndex.value,
                              children: Routes.homeTabs.values.toList(),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  PreferredSizeWidget _appBar() {
    if (screen.isPhone) {
      return AppBar();
    }
    return PreferredSize(
      preferredSize: Size(Get.width, appWindow.titleBarHeight),
      child: WindowTitleBarBox(
        child: MoveWindow(),
      ),
    );
  }

  Widget _sideBar({bool isCollapsed = false}) {
    return SideBar(
      screen: screen,
      isCollapsed: isCollapsed,
      initialPath: controller.initialPath,
      onSelected: (path) {
        int index = Routes.homeTabs.keys.toList().indexOf(path);
        if (index >= 0) {
          controller.changeTab(index);
        }
        return;
      },
      sideBarGroups: [
        SideBarGroup(
          title: "ANALYTICS",
          sideBarDestinations: [
            SideBarDestination(
              title: "Home",
              icon: IconlyLight.home,
              boldIcon: IconlyBold.home,
              path: Routes.HOME_TAB,
            ),
            SideBarDestination(
              title: "Reports",
              icon: IconlyLight.chart,
              boldIcon: IconlyBold.chart,
              path: Routes.REPORTS_TAB,
            ),
          ],
        ),
        SideBarGroup(
          title: "MAIN MENU",
          sideBarDestinations: [
            SideBarDestination(
              title: "Customers",
              icon: IconlyLight.user3,
              boldIcon: IconlyBold.user3,
              path: Routes.CUSTOMERS_TAB,
            ),
            SideBarDestination(
              title: "Vendors",
              icon: Icons.settings,
              path: '/vendors',
            ),
            SideBarDestination(
              title: "Items",
              icon: Icons.settings,
              path: '/items',
            ),
            SideBarDestination(
              title: "Sales",
              icon: Icons.settings,
              path: '/sales',
            ),
            SideBarDestination(
              title: "Purchase",
              icon: Icons.settings,
              path: '/purchase',
            ),
            SideBarDestination(
              title: "Expenses",
              icon: Icons.info_outline_rounded,
              path: '/expenses',
            ),
            SideBarDestination(
              title: "Cash & Bank",
              icon: IconlyLight.wallet,
              boldIcon: IconlyBold.wallet,
              path: '/cash',
            ),
          ],
        ),
        SideBarGroup(
          title: "OTHERS",
          sideBarDestinations: [
            SideBarDestination(
              title: "Utilities",
              icon: Icons.settings,
              path: '/utilities',
            ),
            SideBarDestination(
              title: "Sync",
              icon: Icons.settings,
              path: '/sync',
            ),
            SideBarDestination(
              title: "Backup/Restore",
              icon: Icons.settings_backup_restore_rounded,
              path: '/backup',
            ),
            SideBarDestination(
              title: "Settings",
              icon: IconlyLight.setting,
              boldIcon: IconlyBold.setting,
              path: '/settings',
            ),
            SideBarDestination(
              title: "Help Center",
              icon: IconlyLight.infoSquare,
              boldIcon: IconlyBold.infoSquare,
              path: '/help-center',
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
          TopBar(
            screen: screen,
          ),
          Obx(() {
            return Expanded(
              child: IndexedStack(
                index: controller.tabIndex.value,
                children: Routes.homeTabs.values.toList(),
              ),
            );
          })
        ],
      ),
    );
  }
}
