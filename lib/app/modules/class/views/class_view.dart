import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_scaffold.dart';
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
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: screen.context.theme.primaryColorDark,
                          borderRadius: BorderRadius.circular(12),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ResourceListView(
                            repository: Get.find<PackageRepository>(),
                            title: "Packages",
                            description:
                                "Add, Update or Delete the packages of this class.",
                            canAdd: Get.find<AuthService>().canAdd("Designations"),
                            tileBuilder: (controller, data) {
                              return Container(
                                width: Get.width,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.title ?? "-",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                            color: Colors.grey.shade900,
                                          ),
                                        ),
                                        Text(
                                          "₹${data.price}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    if (Get.find<AuthService>()
                                        .canEdit("Designations"))
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.updateTile(data);
                                          },
                                          child: Icon(Icons.edit,
                                              color: Colors.green.shade700),
                                        ),
                                      ),
                                    if (Get.find<AuthService>()
                                        .canDelete("Designations"))
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.destroyTile(data);
                                          },
                                          child: Icon(Icons.delete,
                                              color: Colors.red.shade700),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        const VerticalDivider(),
                        const SizedBox(width: 20),
                        Expanded(
                          child: FutureBuilder(
                            future: Get.find<SubscriptionRepository>().fetch(queries: {'class_id':Get.parameters['id']}),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return const Center(
                                  child: Text("No Data"),
                                );
                              }
                              return ListView(
                                children: [
                                  for(var data in snapshot.data!)
                                    ListTile(
                                      title: Text(data.customer?.name??"-"),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
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
