import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/widgets/plus_widgets/plus_navigation_rail.dart';

class ErpSettingsScaffold extends StatelessWidget {
  const ErpSettingsScaffold(
      {Key? key, required this.screen, required this.path, required this.body})
      : super(key: key);
  final String path;
  final ResponsiveScreen screen;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return ErpScaffold(
      path: Routes.SETTINGS,
      screen: screen,
      body: Scaffold(
        body: Container(
          width: Get.width,
          margin: const EdgeInsets.only(right: 16, left: 16, top: 20),
          padding: const EdgeInsets.only(top: 2, left: 5, right: 7),
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/settings.png'),
              //   fit: BoxFit.fitWidth,
              //   alignment: Alignment.topCenter,
              // ),
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Settings",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        // letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Manage your account settings and preferences.",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.1,
                        wordSpacing: 0.1,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Divider(
                thickness: 2,
                color: Colors.grey.shade100,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SizedBox(
                  width: Get.width,
                  child: Row(
                    children: [
                      Container(
                        height: Get.height,
                        color: Colors.white,
                        child: PlusNavigationRail(
                          width: 160,
                          onChanged: (path) {
                            Get.toNamed(path);
                          },
                          path: path,
                          destinations:
                              Get.find<AuthService>().getSettingsTabs(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: body,
                        ),
                      )
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
