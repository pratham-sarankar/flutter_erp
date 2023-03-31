import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/users/controllers/user_form_controller.dart';
import 'package:flutter_erp/widgets/form_field_widgets/employee_selection_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_password_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_text_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/permission_group_selection_form_field.dart';

import 'package:get/get.dart';

class UserFormView extends GetView<UserFormController> {
  const UserFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.5,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(maxHeight: Get.height * 0.9),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.isUpdating ? "Update User" : "Add User",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colorScheme.onBackground,
              ),
            ),
            Flexible(
              child: Form(
                key: controller.formKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  children: [
                    const SizedBox(height: 20),
                    EmployeeSelectionFormField(
                      initialValue: controller.user.employee,
                      title: "Select Employee",
                      onSaved: (value) {
                        controller.user.employeeId = value?.id;
                      },
                    ),
                    const SizedBox(height: 20),
                    PermissionGroupSelectionFormField(
                      initialValue: controller.user.permissionGroup,
                      title: "Permission Group",
                      isRequired: true,
                      onSaved: (value) {
                        controller.user.groupId =
                            (value?.isEmpty ?? true) ? null : value?.id;
                      },
                    ),
                    const SizedBox(height: 20),
                    ErpTextFormField(
                      title: "Username",
                      initialValue: controller.user.username,
                      onSaved: (value) {
                        controller.user.username =
                            (value?.isEmpty ?? true) ? null : value;
                      },
                    ),
                    const SizedBox(height: 20),
                    ErpPasswordFormField(
                      title: "Password",
                      initialValue: controller.user.password,
                      isRequired: !controller.isUpdating,
                      onSaved: (value) {
                        controller.user.password =
                            (value?.isEmpty ?? true) ? null : value;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _footer() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Obx(
                  () => Text(
                    controller.error.value,
                    style: TextStyle(
                      color: Get.theme.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(
                        result: false,
                      );
                    },
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 18, horizontal: 35),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      fixedSize: const MaterialStatePropertyAll(Size(140, 40)),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.submit();
                    },
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 18, horizontal: 45),
                      ),
                      fixedSize: const MaterialStatePropertyAll(Size(140, 40)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    child: Obx(
                      () => controller.isLoading.value
                          ? const CupertinoActivityIndicator(
                              color: Colors.white)
                          : const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
