import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/widgets/confirmation_dialog.dart';
import 'package:resource_manager/widgets/widgets.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.screen});

  final ResponsiveScreen screen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Container(
          //   margin: EdgeInsets.only(
          //     top: ((!kIsWeb ? appWindow.titleBarHeight : 0)),
          //     left: max(Get.width * 0.015, 20),
          //   ),
          //   width: max(Get.width * 0.21, 220),
          //   child: CupertinoTextField(
          //     prefix: Padding(
          //       padding: const EdgeInsets.only(left: 13),
          //       child: Icon(
          //         CupertinoIcons.search,
          //         size: 20,
          //         color: context.theme.iconTheme.color,
          //       ),
          //     ),
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w300,
          //       color: context.theme.colorScheme.secondary,
          //     ),
          //     padding: const EdgeInsets.only(
          //         top: 13, bottom: 13, left: 10, right: 10),
          //     placeholder: "Search Keywords",
          //     cursorHeight: 16,
          //     placeholderStyle: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w300,
          //       color: context.theme.colorScheme.onSurface,
          //     ),
          //     clearButtonMode: OverlayVisibilityMode.editing,
          //     decoration: BoxDecoration(
          //       color: context.theme.colorScheme.surface,
          //       border: Border.all(
          //         color: context.theme.outlinedButtonTheme.style!.side!
          //             .resolve({})!.color,
          //       ),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          // ),
          const Spacer(),
          if (screen.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                // const _TopBarButton(
                //     icon: IconlyLight.notification,
                //     boldIcon: IconlyBold.notification),
                // const _TopBarButton(
                //     icon: IconlyLight.plus, boldIcon: IconlyBold.plus),
                // SizedBox(width: Get.width * 0.012),
                VerticalDivider(),
              ],
            ),
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onSelected: (value) async {
              switch (value) {
                case "my_profile":
                  Get.toNamed(Routes.PROFILE);
                  break;
                case "logout":
                  bool? sure = await showDialog(
                    context: context,
                    builder: (context) => const ConfirmationDialog(
                      message: "Are you sure you want to logout?",
                    ),
                  );
                  if (sure ?? false) {
                    await Get.find<AuthService>().logout();
                    Get.toNamed(Routes.LOGIN);
                  }
                  return;
              }
            },
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  padding: const EdgeInsets.only(right: 50, left: 20),
                  height: 38,
                  value: 'my_profile',
                  child: Row(
                    children: const [
                      Icon(Icons.person, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "My Profile",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(height: 1),
                PopupMenuItem(
                  padding: const EdgeInsets.only(right: 50, left: 20),
                  value: "logout",
                  height: 38,
                  child: Row(
                    children: const [
                      Icon(Icons.logout, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Logout",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ];
            },
            tooltip: "My profile",
            position: PopupMenuPosition.under,
            elevation: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: Get.width * 0.015,
                  height: double.infinity,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0,
                        color: context.theme.shadowColor,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                          Get.find<AuthService>().currentUser.getPhotoUrl()),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                if (screen.isDesktop)
                  Row(
                    children: [
                      SizedBox(width: Get.width * 0.01),
                      Text(
                        Get.find<AuthService>().currentUser.getName(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: context.theme.colorScheme.secondary,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.01),
                    ],
                  ),
                SizedBox(width: Get.width * 0.01),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22,
                  color: context.theme.iconTheme.color,
                ),
                SizedBox(width: Get.width * 0.01),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TopBarButton extends StatefulWidget {
  const _TopBarButton({
    required this.icon,
    this.boldIcon,
  });

  final IconData icon;
  final IconData? boldIcon;

  @override
  State<_TopBarButton> createState() => __TopBarButtonState();
}

class __TopBarButtonState extends State<_TopBarButton> {
  late bool _isHovered;

  @override
  void initState() {
    _isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (!kIsWeb ? appWindow.titleBarHeight : 0)),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovered = false;
          });
        },
        child: OutlinedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(
              (states) {
                return const EdgeInsets.all(20);
              },
            ),
            shape: MaterialStateProperty.all(
              const CircleBorder(),
            ),
          ),
          onPressed: () async {
            var result = await Get.dialog(ResourceDialog(resource: Customer()));
            (result);
            // Get.changeThemeMode(
            //     Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (!_isHovered)
                Icon(
                  widget.boldIcon ?? widget.icon,
                  size: 20,
                  color: context.theme.primaryIconTheme.color,
                ),
              Icon(
                widget.icon,
                size: 20,
                color: _isHovered
                    ? context.theme.primaryColor
                    : context.theme.iconTheme.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
