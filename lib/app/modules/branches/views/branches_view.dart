import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/widgets/global_widgets/branch_card.dart';
import '../controllers/branches_controller.dart';

class BranchesView extends GetResponsiveView<BranchesController> {
  BranchesView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.BRANCHES,
      body: Scaffold(
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Branches",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                height: 1.4,
                              ),
                            ),
                            Text(
                              "Add, delete or update the branches of your company.",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Obx(
                          () => TextButton(
                            child: Row(
                              children: controller.isRefreshing.value
                                  ? [
                                      const SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          color: Colors.grey,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ]
                                  : const [
                                      Icon(
                                        CupertinoIcons.refresh,
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      Text("Refresh"),
                                    ],
                            ),
                            onPressed: () {
                              controller.refresh();
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        TextButton(
                          child: Row(
                            children: const [
                              Icon(CupertinoIcons.add, size: 16),
                              SizedBox(width: 5),
                              Text("Add Branch"),
                            ],
                          ),
                          onPressed: () {
                            controller.createNewBranch();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 15,
                      children: controller.branches
                          .map(
                            (branch) => BranchCard(
                              branch: branch,
                              onUpdate: controller.updateBranch,
                              onDelete: controller.deleteBranch,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      screen: screen,
    );
  }
}
