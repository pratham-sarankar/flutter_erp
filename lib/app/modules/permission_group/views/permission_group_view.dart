import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/permission_group.dart';
import 'package:flutter_erp/app/data/repositories/permission_group_repository.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/resource_manager.dart';

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
                      data.name ?? "",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        color: Colors.grey.shade900,
                      ),
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
                GestureDetector(
                  onTap: () {
                    controller.updateTile(data);
                  },
                  child: Icon(Icons.edit, color: Colors.green.shade700),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    controller.destroyTile(data);
                  },
                  child: Icon(Icons.delete, color: Colors.red.shade700),
                ),
                const SizedBox(width: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
