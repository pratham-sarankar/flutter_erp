import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/user.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetResponsiveView<UsersController> {
  UsersView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpSettingsScaffold(
      screen: screen,
      path: Routes.USERS,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Users",
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
                      "Add, edit, delete and update users of your company.",
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
                    controller.insertUser();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: controller.obx(
              (state) => ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: state!.length,
                itemBuilder: (context, index) {
                  return tileBuilder(controller, state[index]);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget tileBuilder(UsersController controller, User state) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(state.getPhotoUrl()),
          ),
          // minVerticalPadding: 25,
          minLeadingWidth: 0,
          // horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.only(left: 5),
          title: Text(
            state.name ?? "-",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          subtitle: Text(
            state.employee?.getName() ?? "-",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (Get.find<AuthService>().canEdit("Users"))
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      controller.updateTile(state);
                    },
                    child: Icon(Icons.edit, color: Colors.green.shade700),
                  ),
                ),
              if (Get.find<AuthService>().canDelete("Users"))
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      controller.destroyTile(state);
                    },
                    child: Icon(Icons.delete, color: Colors.red.shade700),
                  ),
                ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
