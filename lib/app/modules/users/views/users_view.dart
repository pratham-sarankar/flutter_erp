import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetResponsiveView<UsersController> {
  UsersView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpSettingsScaffold(
      screen: screen,
      path: Routes.USERS,
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Users",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Add, Update or Delete the users of your company.",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          letterSpacing: 0.1,
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
                        Icon(
                          CupertinoIcons.add,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text("Add"),
                      ],
                    ),
                    onPressed: () {
                      controller.createNewUser();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
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
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green,
                              image: controller.users[index].getPhotoUrl() ==
                                      null
                                  ? null
                                  : DecorationImage(
                                      image: NetworkImage(
                                        controller.users[index].getPhotoUrl()!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.users[index].username ?? "-",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                  color: Colors.grey.shade900,
                                ),
                              ),
                              Text(
                                controller.groups.firstWhere((element) {
                                  return controller.users[index].groupId ==
                                      element.id;
                                }).getName(),
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
                              controller.updateUser(controller.users[index]);
                            },
                            child:
                                Icon(Icons.edit, color: Colors.green.shade700),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              controller.deleteUser(controller.users[index]);
                            },
                            child:
                                Icon(Icons.delete, color: Colors.red.shade700),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    );
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
