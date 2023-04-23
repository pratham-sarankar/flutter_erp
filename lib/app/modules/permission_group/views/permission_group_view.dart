import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/permission.dart';
import 'package:flutter_erp/app/data/models/permission_group.dart';
import 'package:flutter_erp/app/data/repositories/module_repository.dart';
import 'package:flutter_erp/app/data/repositories/permission_group_repository.dart';
import 'package:flutter_erp/app/data/repositories/permission_repository.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/resource_manager.dart';
import 'package:resource_manager/widgets/confirmation_dialog.dart';

import '../../../data/services/auth_service.dart';
import '../controllers/permission_group_controller.dart';

class PermissionGroupView extends GetResponsiveView<UserGroupController> {
  PermissionGroupView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpSettingsScaffold(
      screen: screen,
      path: Routes.PERMISSION_GROUPS,
      body: ResourceListView<PermissionGroup>(
        repository: Get.find<PermissionGroupRepository>(),
        title: "Permission Groups",
        description: "Configure different permission groups for your users.",
        canAdd: Get.find<AuthService>().canAdd("Permission Groups"),
        tileBuilder: (tileController, data) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: Colors.grey.shade100,
            child: PlusAccordion(
              onChanged: (isExpanded) {
                if (isExpanded) {
                  controller.permissions = data.permissions;
                }
              },
              isExpandable:
                  Get.find<AuthService>().canEdit("Permission Groups") &&
                      (!data.isAdminGroup),
              header: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              data.name ?? "",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            if (data.isAdminGroup)
                              const Padding(
                                padding: EdgeInsets.only(right: 2),
                                child: Icon(CupertinoIcons.lock_fill, size: 15),
                              ),
                          ],
                        ),
                        Text(
                          data.getUsersCount() == 0
                              ? "No Users"
                              : "${data.getUsersCount()} users",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (Get.find<AuthService>().canEdit("Permission Groups") &&
                        (!data.isAdminGroup))
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: PopupMenuButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onSelected: (value) async {
                            tileController.updateState(() async {
                              await Get.find<PermissionRepository>().insert(
                                  Permission(
                                      moduleId: value, groupId: data.id));
                            });
                          },
                          position: PopupMenuPosition.under,
                          itemBuilder: (context) {
                            print(Get.find<ModuleRepository>().modules.length);
                            var modules = Get.find<ModuleRepository>()
                                .modules
                                .where(
                                    (module) => !data.modules.contains(module))
                                .toList();
                            (modules);
                            return [
                              for (var module in modules)
                                PopupMenuItem(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  height: 38,
                                  value: module.id,
                                  child: Row(
                                    children: [
                                      Text(
                                        module.name ?? "",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                            ];
                          },
                          child: Icon(
                            CupertinoIcons.add_circled,
                            size: 20,
                            color: screen.context.theme.primaryColor,
                          ),
                        ),
                      ),
                    if (Get.find<AuthService>().canEdit("Permission Groups") &&
                        (!data.isAdminGroup))
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: GestureDetector(
                          onTap: () {
                            tileController.updateTile(data);
                          },
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                    if (Get.find<AuthService>()
                            .canDelete("Permission Groups") &&
                        (!data.isAdminGroup))
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 10),
                        child: GestureDetector(
                          onTap: () {
                            tileController.destroyTile(data);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              child: SizedBox(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(0.5),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder(
                    top: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                    verticalInside: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                    horizontalInside: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  children: [
                    TableRow(
                      children: [
                        SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              "Module",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              "View",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              "Add",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              "Edit",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              "Delete",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                    for (var permission in data.permissions)
                      TableRow(
                        children: [
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                permission.module?.name ?? "-",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.6,
                            child: CupertinoSwitch(
                              value: permission.canView,
                              onChanged: (value) async {
                                tileController.updateState(() async {
                                  permission.canView = value;
                                  await Get.find<PermissionRepository>()
                                      .update(permission);
                                });
                              },
                            ),
                          ),
                          Transform.scale(
                            scale: 0.6,
                            child: CupertinoSwitch(
                              value: permission.canAdd,
                              onChanged: (value) async {
                                tileController.updateState(() async {
                                  permission.canAdd = value;
                                  await Get.find<PermissionRepository>()
                                      .update(permission);
                                });
                              },
                            ),
                          ),
                          Transform.scale(
                            scale: 0.6,
                            child: CupertinoSwitch(
                              value: permission.canEdit,
                              onChanged: (value) async {
                                tileController.updateState(() async {
                                  permission.canEdit = value;
                                  await Get.find<PermissionRepository>()
                                      .update(permission);
                                });
                              },
                            ),
                          ),
                          Transform.scale(
                            scale: 0.6,
                            child: CupertinoSwitch(
                              value: permission.canDelete,
                              onChanged: (value) async {
                                tileController.updateState(() async {
                                  permission.canDelete = value;
                                  await Get.find<PermissionRepository>()
                                      .update(permission);
                                });
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              bool? sure = await Get.dialog(
                                  const ConfirmationDialog(
                                      message:
                                          "Are you sure you want to perform this action?"));
                              if (!(sure ?? false)) return;
                              tileController.updateState(() async {
                                await Get.find<PermissionRepository>()
                                    .destroy(permission);
                              });
                            },
                            child: const Icon(Icons.close, size: 18),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
