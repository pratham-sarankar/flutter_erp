import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/data/abstracts/resource.dart';
import 'package:resource_manager/widgets/plus_widgets/plus_form_field.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetResponsiveView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    var user = Get.find<AuthService>().currentUser;
    return ErpSettingsScaffold(
      screen: screen,
      path: Routes.PROFILE,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "View and edit the details of your profile",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.grey.shade700,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 15),
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: PlusFormField(
                            title: "First Name",
                            initialText: user.employee?.firstName,
                            enabled: false,
                            type: FieldType.name,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: PlusFormField(
                            title: "Last Name",
                            initialText: user.employee?.lastName,
                            enabled: false,
                            type: FieldType.name,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: PlusFormField(
                            title: "Username",
                            initialText: user.username,
                            enabled: false,
                            type: FieldType.name,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: PlusFormField(
                            title: "Email",
                            initialText: user.employee?.email,
                            enabled: false,
                            type: FieldType.email,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: PlusFormField(
                            title: "Phone Number",
                            initialText: user.employee?.phoneNumber,
                            enabled: false,
                            type: FieldType.phoneNumber,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: PlusFormField(
                            title: "Date of birth",
                            initialText: user.employee?.getDateOfBirth(),
                            enabled: false,
                            type: FieldType.date,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Update Password",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Pass the current password and a new password, then click on save to update password.",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: PlusFormField(
                            title: "Password",
                            enabled: true,
                            controller: controller.password,
                            type: FieldType.password,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: PlusFormField(
                            title: "New Password",
                            enabled: true,
                            type: FieldType.password,
                            controller: controller.newPassword,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Obx(
                      () => TextButton(
                        onPressed: () {
                          controller.updatePassword();
                        },
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                child: Text("Save"),
                              ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
