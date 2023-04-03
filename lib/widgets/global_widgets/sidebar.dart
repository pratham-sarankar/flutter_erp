import 'dart:math';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:flutter_erp/app/data/repositories/branch_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/widgets/dialogs/branch_selection_dialog.dart';
import 'package:get/get.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    required this.screen,
    required this.initialPath,
    required this.onSelected,
    required this.isCollapsed,
    required this.sideBarGroups,
    this.minWidth = 250,
  });

  final ResponsiveScreen screen;
  final double minWidth;
  final List<SideBarGroup> sideBarGroups;
  final String initialPath;
  final bool isCollapsed;
  final Function(String) onSelected;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late String _selectedPath;
  late bool _isCollapsed;

  @override
  void initState() {
    _isCollapsed = widget.isCollapsed;
    _selectedPath = widget.initialPath;
    super.initState();
  }

  double getWidth() {
    if (widget.screen.isPhone) {
      return Get.width * 0.7;
    } else {
      return _isCollapsed ? 80 : 260;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: getWidth(),
      duration: const Duration(milliseconds: 200),
      child: Row(
        children: [
          Expanded(
            child: Drawer(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: context.theme.dividerColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _SidebarTitle(
                                isCollapsed: _isCollapsed,
                                onTap: () {
                                  setState(() {
                                    _isCollapsed = !_isCollapsed;
                                  });
                                },
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: _BranchTile(isCollapsed: _isCollapsed),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: widget.sideBarGroups
                            .map(
                              (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: _isCollapsed
                                        ? Container()
                                        : Padding(
                                            padding: EdgeInsets.only(
                                              left: max(Get.width * 0.02, 32),
                                              top: 30,
                                              bottom: 10,
                                            ),
                                            child: Text(
                                              e.title,
                                              style: TextStyle(
                                                fontSize: 12,
                                                letterSpacing: 0.3,
                                                fontWeight: FontWeight.w500,
                                                color: Get.theme.colorScheme
                                                    .onBackground,
                                              ),
                                            ),
                                          ),
                                  ),
                                  FocusTraversalGroup(
                                    child: Column(
                                      children: [
                                        for (int i = 0;
                                            i < e.sideBarDestinations.length;
                                            i++)
                                          FocusTraversalOrder(
                                            order:
                                                NumericFocusOrder(i.toDouble()),
                                            child: _NavigatorTile(
                                              title: e
                                                  .sideBarDestinations[i].title,
                                              icon:
                                                  e.sideBarDestinations[i].icon,
                                              path:
                                                  e.sideBarDestinations[i].path,
                                              isCollapsed: _isCollapsed,
                                              isSelected: e
                                                      .sideBarDestinations[i]
                                                      .path ==
                                                  _selectedPath,
                                              onSelected: () {
                                                setState(() {
                                                  _selectedPath = e
                                                      .sideBarDestinations[i]
                                                      .path;
                                                });
                                                widget.onSelected(e
                                                    .sideBarDestinations[i]
                                                    .path);
                                              },
                                              boldIcon: e.sideBarDestinations[i]
                                                  .boldIcon,
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(),
        ],
      ),
    );
  }
}

class SideBarGroup {
  final String title;
  final List<SideBarDestination> sideBarDestinations;

  SideBarGroup({
    required this.title,
    required this.sideBarDestinations,
  });
}

class SideBarDestination {
  final String title;
  final IconData icon;
  final IconData? boldIcon;
  final String path;

  SideBarDestination({
    required this.title,
    required this.icon,
    this.boldIcon,
    required this.path,
  });
}

class _SidebarTitle extends StatefulWidget {
  const _SidebarTitle({required this.onTap, required this.isCollapsed});

  final VoidCallback onTap;
  final bool isCollapsed;

  @override
  State<_SidebarTitle> createState() => __SidebarTitleState();
}

class __SidebarTitleState extends State<_SidebarTitle> {
  late bool _isHovered;

  @override
  void initState() {
    _isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
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
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: widget.isCollapsed
            ? GestureDetector(
                onTap: () {
                  widget.onTap();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 25),
                    Icon(
                      CupertinoIcons.bars,
                      size: 30,
                      color: context.theme.iconTheme.color,
                    ),
                  ],
                ),
              )
            : _isHovered
                ? GestureDetector(
                    onTap: () {
                      widget.onTap();
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 25),
                        Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: context.theme.iconTheme.color,
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      const SizedBox(width: 25),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gyanish Yoga",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: context.theme.primaryColor,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Each practice is a new beginning.",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                height: 1.3,
                                overflow: TextOverflow.ellipsis,
                                color: context.theme.colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
      ),
    );
  }
}

class _BranchTile extends StatelessWidget {
  const _BranchTile({Key? key, required this.isCollapsed}) : super(key: key);
  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    var branch = Get.find<AuthService>().currentBranch;
    return GestureDetector(
      onTap: () async {
        if (!Get.find<AuthService>().canEdit("Branches")) return;
        List<Branch> branches = await Get.find<BranchRepository>().fetch();
        Branch? branch =
            await Get.dialog(BranchSelectionDialog(branches: branches));
        if (branch == null) return;
        await Get.find<AuthService>().setCurrentBranch(branch);
        var route = Get.currentRoute;
        Get.deleteAll();
        Get.offAndToNamed(route);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: isCollapsed
            ? Center(
                child: Image.asset("assets/branch.png", width: 30),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.only(
                    top: Get.height * 0.012,
                    bottom: Get.height * 0.012,
                    left: 25,
                  ),
                  width: 200,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: context.theme.colorScheme.surface,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: max(Get.width * 0.008, 13),
                      ),
                      Image.asset("assets/branch.png", width: 30),
                      SizedBox(
                        width: max(Get.width * 0.007, 12),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                branch.name ?? "",
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  color: context.theme.colorScheme.secondary,
                                ),
                              ),
                              Text(
                                branch.address ?? "-",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  overflow: TextOverflow.ellipsis,
                                  color: context.theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Get.theme.colorScheme.onSurface,
                        size: 18,
                      ),
                      SizedBox(
                        width: max(Get.width * 0.01, 16),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _NavigatorTile extends StatefulWidget {
  const _NavigatorTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
    required this.path,
    required this.isCollapsed,
    this.boldIcon,
  });

  final String title;
  final IconData icon;
  final IconData? boldIcon;
  final String path;
  final bool isSelected;
  final bool isCollapsed;
  final VoidCallback onSelected;

  @override
  State<_NavigatorTile> createState() => _NavigatorTileState();
}

class _NavigatorTileState extends State<_NavigatorTile> {
  late bool _isHovered;
  late bool _isFocused;
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _isFocused = false;
    _isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: widget.isSelected,
      canRequestFocus: true,
      onFocusChange: (focus) {
        setState(() {
          _isFocused = focus;
        });
      },
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          widget.onSelected();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
        child: GestureDetector(
          onTap: () {
            _focusNode.requestFocus();
            widget.onSelected();
          },
          child: Container(
              color: _isHovered || _isFocused
                  ? context.theme.hoverColor
                  : context.theme.drawerTheme.backgroundColor,
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    width: 2,
                    height: widget.isCollapsed ? 55 : 40,
                    decoration: BoxDecoration(
                      color: widget.isSelected
                          ? context.theme.primaryColor
                          : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(100),
                      ),
                    ),
                  ),
                  Expanded(
                    child: widget.isCollapsed
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  widget.boldIcon ?? widget.icon,
                                  size: 20,
                                  color: context.theme.primaryIconTheme.color,
                                ),
                                Icon(
                                  widget.icon,
                                  size: 20,
                                  color: widget.isSelected
                                      ? context.theme.primaryColor
                                      : context.theme.iconTheme.color,
                                ),
                              ],
                            ),
                          )
                        : ListTile(
                            leading: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  widget.boldIcon ?? widget.icon,
                                  size: 20,
                                  color: context.theme.primaryIconTheme.color,
                                ),
                                Icon(
                                  widget.icon,
                                  size: 20,
                                  color: widget.isSelected
                                      ? context.theme.primaryColor
                                      : context.theme.iconTheme.color,
                                ),
                              ],
                            ),
                            mouseCursor: SystemMouseCursors.click,
                            horizontalTitleGap: 0,
                            contentPadding: const EdgeInsets.only(left: 25),
                            title: Text(
                              widget.title,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: widget.isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                fontSize: 14,
                                color: widget.isSelected
                                    ? context.theme.primaryColor
                                    : context.theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
