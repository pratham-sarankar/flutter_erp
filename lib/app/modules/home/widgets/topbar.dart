import 'dart:math';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.screen});
  final ResponsiveScreen screen;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75 + appWindow.titleBarHeight,
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
          Container(
            margin: EdgeInsets.only(
              top: appWindow.titleBarHeight,
              left: max(Get.width * 0.015, 20),
            ),
            width: max(Get.width * 0.21, 220),
            child: CupertinoTextField(
              prefix: Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Icon(
                  CupertinoIcons.search,
                  size: 20,
                  color: context.theme.iconTheme.color,
                ),
              ),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: context.theme.colorScheme.secondary,
              ),
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 10, right: 10),
              placeholder: "Search Keywords",
              cursorHeight: 16,
              placeholderStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: context.theme.colorScheme.onSurface,
              ),
              clearButtonMode: OverlayVisibilityMode.editing,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surface,
                border: Border.all(
                  color: context.theme.outlinedButtonTheme.style!.side!
                      .resolve({})!.color,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const Spacer(),
          if (screen.isDesktop)
            Row(
              children: [
                const _TopBarButton(
                    icon: IconlyLight.notification,
                    boldIcon: IconlyBold.notification),
                const _TopBarButton(
                    icon: IconlyLight.plus, boldIcon: IconlyBold.plus),
                SizedBox(width: Get.width * 0.012),
                const VerticalDivider(),
              ],
            ),
          Padding(
            padding: EdgeInsets.only(top: appWindow.titleBarHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: Get.width * 0.015),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: context.theme.shadowColor,
                      ),
                    ],
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://randomuser.me/api/portraits/med/men/75.jpg'),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                if (screen.isDesktop)
                  Row(
                    children: [
                      SizedBox(width: Get.width * 0.01),
                      Text(
                        "James Dexter",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: context.theme.colorScheme.secondary),
                      ),
                    ],
                  ),
                SizedBox(width: Get.width * 0.01),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22,
                  color: context.theme.primaryIconTheme.color,
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
      padding: EdgeInsets.only(top: appWindow.titleBarHeight),
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
          onPressed: () {
            Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
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
