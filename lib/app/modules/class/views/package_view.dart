import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/package.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/modules/class/controllers/package_controller.dart';
import 'package:flutter_erp/app/modules/class/views/package_form_view.dart';
import 'package:flutter_erp/app/modules/subscriptions/views/subscription_form_view.dart';
import 'package:flutter_erp/widgets/dialogs/deletion_dialog.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/resource_manager.dart';

class PackageView extends GetView<PackageController> {
  const PackageView({Key? key}) : super(key: key);

  @override
  PackageController get controller =>
      Get.find<PackageController>(tag: Get.parameters["id"]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Packages",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Add, Update or Delete the packages of this class.",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      height: 1,
                      color: Colors.grey.shade700,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              child: Row(
                children: const [
                  Icon(
                    CupertinoIcons.refresh,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text("Refresh"),
                ],
              ),
              onPressed: () {
                controller.reload();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextButton(
                child: Row(
                  children: const [
                    Icon(
                      CupertinoIcons.add,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text("Add"),
                  ],
                ),
                onPressed: () {
                  controller.insertPackage();
                },
              ),
            ),
          ],
        ),
        Obx(
          () {
            return ListView(
              padding: const EdgeInsets.only(top: 20),
              shrinkWrap: true,
              children: [
                for (final data in controller.packages) packageTile(data),
              ],
            );
          },
        )
      ],
    );
  }

  Widget packageTile(Package data) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: GestureDetector(
              onTap: () async {
                var result = await Get.dialog(
                  const SubscriptionFormView(),
                  arguments: Subscription(
                    package: data,
                    packageId: data.id,
                    classId: data.classId,
                    branchId: Get.find<AuthService>().currentBranch.id,
                  ),
                );
                if (result) {
                  Get.find<ToastService>()
                      .showSuccessToast("Subscription added successfully.");
                }
              },
              child: Icon(
                CupertinoIcons.add,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          if (Get.find<AuthService>().canEdit("Designations"))
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  var result = await Get.dialog(
                    const PackageFormView(),
                    arguments: data,
                  );
                  if (result) {
                    controller.reload();
                  }
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          if (Get.find<AuthService>().canDelete("Designations"))
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: GestureDetector(
                onTap: () async {
                  var result = await Get.dialog(
                    DeletionDialog(
                      onDelete: () async {
                        await Get.find<PackageRepository>().destroy(data);
                        return true;
                      },
                    ),
                  );
                  if (result) {
                    controller.reload();
                  }
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red.shade700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
