import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/Users/user.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/models/user_group.dart';
import 'package:flutter_erp/app/data/models/users/user_credential.dart';
import 'package:flutter_erp/app/data/widgets/plus_widgets/plus_dropdown.dart';
import 'package:flutter_erp/app/data/widgets/plus_widgets/plus_form_field.dart';
import 'package:get/get.dart';

class UserDialog extends StatefulWidget {
  const UserDialog({Key? key, this.user, this.groups, this.employees})
      : super(key: key);
  final User? user;
  final List<UserGroup>? groups;
  final List<Employee>? employees;
  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  late final GlobalKey<FormState> _formKey;
  late User user;
  late String? password;
  late int? groupId;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    user = widget.user ?? User();
    password = '';
    groupId = user.groupId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.3,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add User",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 22),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _basicDetails(),
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

  Widget _basicDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (user.id == null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Opacity(
                opacity: 0.8,
                child: Text(
                  "Employees",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.theme.colorScheme.onBackground,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              PlusDropDown(
                initialValue: user.groupId,
                onChanged: (value) {},
                items: [
                  DropdownMenuItem<int>(
                    value: null,
                    child: Text(
                      "Select a employee",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  ...widget.employees!
                      .map<DropdownMenuItem<int>>(
                        (employee) => DropdownMenuItem<int>(
                          value: employee.id,
                          child: Text(
                            employee.getName(),
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: context.theme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
                onSaved: (value) {
                  user.employeeId = value;
                },
              ),
            ],
          ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Opacity(
              opacity: 0.8,
              child: Text(
                "User Groups",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.theme.colorScheme.onBackground,
                ),
              ),
            ),
            const SizedBox(height: 10),
            PlusDropDown(
              initialValue: user.groupId,
              onChanged: (value) {},
              items: [
                DropdownMenuItem<int>(
                  value: null,
                  child: Text(
                    "Select a group",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                ...widget.groups!
                    .map<DropdownMenuItem<int>>(
                      (group) => DropdownMenuItem<int>(
                        value: group.id,
                        child: Text(
                          group.getName(),
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.theme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
              onSaved: (value) {
                user.groupId = value;
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        PlusFormField(
          title: "Username",
          type: TextInputType.name,
          hintText: "John",
          initialText: user.username,
          onSaved: (value) {
            user.username = value;
          },
        ),
        const SizedBox(height: 20),
        PlusFormField(
          title: "Password",
          type: TextInputType.visiblePassword,
          onSaved: (value) {
            password = value;
          },
        ),
      ],
    );
  }

  Widget _footer() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
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
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  Get.back(
                      result: UserCredential(user: user, password: password));
                }
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
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
