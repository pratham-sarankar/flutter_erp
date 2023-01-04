import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:flutter_erp/app/data/services/file_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/utils/extensions/form_validator.dart';
import 'package:flutter_erp/app/data/widgets/plus_widgets/plus_dropdown.dart';
import 'package:flutter_erp/app/data/widgets/plus_widgets/plus_form_field.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class EmployeeDialog extends StatefulWidget {
  const EmployeeDialog({Key? key, this.employee, this.designations})
      : super(key: key);
  final Employee? employee;
  final List<Designation>? designations;
  @override
  State<EmployeeDialog> createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<EmployeeDialog> {
  late final GlobalKey<FormState> _formKey;
  late Employee employee;
  late int? designationId;
  late Uint8List? image;
  late bool _isLoading;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _isLoading = false;
    employee = widget.employee ?? Employee();
    designationId = employee.designationId;
    image = null;
    initImage();
    super.initState();
  }

  void initImage() async {
    if (employee.getPhotoUrl() == null) return;
    setState(() {
      _isLoading = true;
    });
    var response = await get(Uri.parse(employee.getPhotoUrl()!));
    setState(() {
      _isLoading = false;
      image = response.bodyBytes;
    });
  }

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
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Employee",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 22),
            Opacity(
              opacity: 0.8,
              child: Text(
                "Profile Photo",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.theme.colorScheme.onBackground,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _imageButton(),
            const SizedBox(height: 30),
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

  void _pickImage() async {
    var file = await Get.find<FileService>().pickImage();
    if (file == null) return;
    setState(() {
      image = file.bytes;
      _isLoading = true;
    });
    try {
      String key = await FileRepository.instance.uploadFile(image!);
      employee.photoUrl = key;
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget _imageButton() {
    if (image != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: MemoryImage(image!),
                fit: BoxFit.cover,
              ),
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                : null,
          ),
          Positioned(
            top: -10,
            right: -20,
            child: TextButton(
              onPressed: () {
                setState(() {
                  image = null;
                  employee.photoUrl = null;
                });
              },
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
                fixedSize: MaterialStatePropertyAll(Size(20, 20)),
              ),
              child: const Icon(Icons.clear, size: 16),
            ),
          )
        ],
      );
    }
    return TextButton(
      onPressed: () {
        _pickImage();
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size(150, 120)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return context.theme.primaryColorDark.withOpacity(0.8);
          }
          return context.theme.primaryColorDark;
        }),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : const Icon(
              CupertinoIcons.camera_circle_fill,
              size: 60,
              color: Colors.white,
            ),
    );
  }

  Widget _basicDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PlusFormField(
                title: "First Name",
                type: TextInputType.name,
                hintText: "John",
                initialText: employee.firstName,
                onSaved: (value) {
                  employee.firstName = value;
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: PlusFormField(
                title: "Last Name",
                type: TextInputType.name,
                hintText: "Doe",
                initialText: employee.lastName,
                isRequired: true,
                onSaved: (value) {
                  employee.lastName = value;
                },
                // onValidate: (value) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.designations?.isNotEmpty ?? false)
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Opacity(
                            opacity: 0.8,
                            child: Text(
                              "Designation",
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.theme.colorScheme.onBackground,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          PlusDropDown(
                            initialValue: employee.designationId,
                            items: [
                              DropdownMenuItem<int>(
                                value: null,
                                child: Text(
                                  "Select a designation",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                              ...widget.designations!
                                  .map<DropdownMenuItem<int>>(
                                    (designation) => DropdownMenuItem<int>(
                                      value: designation.id,
                                      child: Text(
                                        designation.getName(),
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: context
                                              .theme.colorScheme.onBackground,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                            onChanged: (value) {
                              employee.designationId = value;
                            },
                            validator: ValidationBuilder().buildDyn(),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                Expanded(
                  flex: 40,
                  child: PlusFormField(
                    title: "Email",
                    type: TextInputType.emailAddress,
                    initialText: employee.email,
                    onSaved: (value) {
                      employee.email = value;
                    },
                    onValidate:
                        ValidationBuilder(optional: true).email().build(),
                    // onValidate: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 60,
              child: PlusFormField(
                title: "Mobile no.",
                isRequired: true,
                initialText: employee.phoneNumber,
                onSaved: (value) {
                  employee.phoneNumber = value;
                },
                onValidate: ValidationBuilder().phone().build(),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 40,
              child: PlusFormField(
                title: "Date of Birth",
                type: TextInputType.datetime,
                hintText: "dd-mm-yyyy",
                initialText: employee.dob == null
                    ? null
                    : DateFormat("dd-M-yyyy").format(employee.dob!),
                onSaved: (value) {
                  if (value == null) return;
                  try {
                    employee.dob = DateFormat("dd-M-yyyy").parse(value);
                  } catch (e) {
                    return;
                  }
                },
              ),
            ),
          ],
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
                if (_isLoading) {
                  return;
                }
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  Get.back(result: employee);
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
