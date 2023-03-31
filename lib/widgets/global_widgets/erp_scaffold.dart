import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/widgets/global_widgets/sidebar.dart';
import 'package:flutter_erp/widgets/global_widgets/topbar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ErpScaffold extends StatelessWidget {
  const ErpScaffold(
      {Key? key,
      required this.path,
      this.appBar,
      required this.screen,
      required this.body})
      : super(key: key);
  final String path;
  final ResponsiveScreen screen;
  final Widget body;
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: screen.isPhone ? appBar ?? AppBar() : null,
      drawer: screen.isPhone ? _sideBar() : null,
      body: getBody(screen),
    );
  }

  Widget getBody(ResponsiveScreen screen) {
    if (screen.isPhone) {
      return _body(withTopbar: false);
    } else if (screen.isTablet) {
      return Stack(
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
      );
    }
    return Row(
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
    );
  }

  Widget _sideBar({bool isCollapsed = false}) {
    return SideBar(
      screen: screen,
      isCollapsed: isCollapsed,
      initialPath: path,
      onSelected: (path) {
        if (Get.currentRoute == path) {
          return;
        } else {
          Get.toNamed(path);
        }
      },
      sideBarGroups: Get.find<AuthService>().getSideBarGroups(),
    );
  }

  Widget _body({bool withTopbar = true}) {
    return Container(
      color: Colors.white.withOpacity(0.2),
      child: Column(
        children: [
          if (withTopbar)
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
