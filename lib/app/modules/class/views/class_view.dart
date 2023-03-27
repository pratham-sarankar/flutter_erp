import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:flutter_erp/app/modules/class/views/package_view.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/modules/class/views/chat_view.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/class_controller.dart';

class ClassView extends GetResponsiveView<ClassController> {
  ClassView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.CLASSES,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Container(
          margin:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: controller.obx(
            (value) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset('assets/class.png', height: 160),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value?.name ?? "-",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              value?.description ?? "-",
                              maxLines: 5,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(IconlyLight.timeSquare, size: 22),
                                const SizedBox(width: 5),
                                Text(
                                  value?.formattedTime ?? "-",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    height: 1.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(IconlyLight.calendar, size: 22),
                                const SizedBox(width: 5),
                                Text(
                                  value?.schedule?.toText(
                                          l10n:
                                              Get.find<RRuleService>().l10n) ??
                                      "-",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    height: 1.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TabBar(
                              tabs: const [
                                Tab(
                                  child: Text("Packages"),
                                ),
                                Tab(
                                  child: Text("Members"),
                                ),
                              ],
                              isScrollable: true,
                              indicatorColor: Colors.grey.shade800,
                              unselectedLabelColor: Colors.grey.shade500,
                              labelColor: Colors.grey.shade800,
                              labelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedLabelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: TabBarView(
                              children: [
                                PackageView(),
                                const ChatView(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            onLoading: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
