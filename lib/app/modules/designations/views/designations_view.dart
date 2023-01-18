import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/resource_manager.dart';

import '../../../data/services/auth_service.dart';
import '../controllers/designations_controller.dart';

class DesignationsView extends GetResponsiveView<DesignationsController> {
  DesignationsView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpSettingsScaffold(
      screen: screen,
      path: Routes.DESIGNATIONS,
      body: ResourceListView(
        repository: Get.find<DesignationRepository>(),
        title: "Designations",
        description: "Add, Update or Delete the designations of your company.",
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
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 18),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.getName(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    Text(
                      data.getEmployeesCount() == 0
                          ? "No Employees"
                          : "${data.getEmployeesCount()} Employees",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (Get.find<AuthService>().canEdit("Designations"))
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        controller.updateTile(data);
                      },
                      child: Icon(Icons.edit, color: Colors.green.shade700),
                    ),
                  ),
                if (Get.find<AuthService>().canDelete("Designations"))
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        controller.destroyTile(data);
                      },
                      child: Icon(Icons.delete, color: Colors.red.shade700),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Row(
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Designations",
      //               style: GoogleFonts.poppins(
      //                 fontWeight: FontWeight.w600,
      //                 fontSize: 16,
      //                 height: 1,
      //               ),
      //             ),
      //             const SizedBox(height: 5),
      //             Text(
      //               "Add, Update or Delete the designations of your company.",
      //               style: GoogleFonts.poppins(
      //                 fontWeight: FontWeight.w400,
      //                 fontSize: 13,
      //                 color: Colors.grey.shade700,
      //                 letterSpacing: 0.1,
      //               ),
      //             ),
      //           ],
      //         ),
      //         const Spacer(),
      //         Obx(
      //           () => TextButton(
      //             child: Row(
      //               children: controller.isRefreshing.value
      //                   ? [
      //                       const SizedBox(
      //                         height: 15,
      //                         width: 15,
      //                         child: CircularProgressIndicator(
      //                           color: Colors.grey,
      //                           strokeWidth: 2,
      //                         ),
      //                       ),
      //                     ]
      //                   : const [
      //                       Icon(
      //                         CupertinoIcons.refresh,
      //                         size: 16,
      //                       ),
      //                       SizedBox(width: 5),
      //                       Text("Refresh"),
      //                     ],
      //             ),
      //             onPressed: () {
      //               controller.refresh();
      //             },
      //           ),
      //         ),
      //         const SizedBox(width: 15),
      //         TextButton(
      //           child: Row(
      //             children: const [
      //               Icon(
      //                 CupertinoIcons.add,
      //                 size: 16,
      //               ),
      //               SizedBox(width: 5),
      //               Text("Add"),
      //             ],
      //           ),
      //           onPressed: () {
      //             controller.createNewDesignation();
      //           },
      //         ),
      //       ],
      //     ),
      //     const SizedBox(height: 20),
      //     Obx(() {
      //       if (controller.isLoading.value) {
      //         return const Expanded(
      //             child: Center(child: CircularProgressIndicator()));
      //       }
      //       return ListView.builder(
      //         shrinkWrap: true,
      //         itemCount: controller.designations.length,
      //         itemBuilder: (context, index) {
      //           return Container(
      //             width: Get.width,
      //             height: 60,
      //             decoration: BoxDecoration(
      //               border: Border(
      //                 bottom: BorderSide(
      //                   color: Colors.grey.shade200,
      //                   width: 1.5,
      //                 ),
      //               ),
      //             ),
      //             child: Row(
      //               children: [
      //                 Container(
      //                   width: 40,
      //                   height: 40,
      //                   decoration: BoxDecoration(
      //                     color: Colors.green.withOpacity(0.7),
      //                     borderRadius: BorderRadius.circular(8),
      //                   ),
      //                 ),
      //                 const SizedBox(width: 18),
      //                 Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       controller.designations[index].getName(),
      //                       style: GoogleFonts.poppins(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w500,
      //                         height: 1.2,
      //                         color: Colors.grey.shade900,
      //                       ),
      //                     ),
      //                     Text(
      //                       controller.designations[index]
      //                                   .getEmployeesCount() ==
      //                               0
      //                           ? "No Employees"
      //                           : "${controller.designations[index].getEmployeesCount()} Employees",
      //                       style: GoogleFonts.poppins(
      //                         fontSize: 12,
      //                         fontWeight: FontWeight.w400,
      //                         color: Colors.grey.shade700,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 const Spacer(),
      //                 GestureDetector(
      //                   onTap: () {
      //                     controller.updateDesignation(
      //                         controller.designations[index]);
      //                   },
      //                   child: Icon(Icons.edit, color: Colors.green.shade700),
      //                 ),
      //                 const SizedBox(width: 20),
      //                 GestureDetector(
      //                   onTap: () {
      //                     controller.deleteDesignation(
      //                         controller.designations[index]);
      //                   },
      //                   child: Icon(Icons.delete, color: Colors.red.shade700),
      //                 ),
      //                 const SizedBox(width: 20),
      //               ],
      //             ),
      //           );
      //         },
      //       );
      //     })
      //   ],
      // ),
    );
  }
}
