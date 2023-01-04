import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_dialog.dart';
import 'package:flutter_erp/app/data/widgets/plus_widgets/plus_form_field.dart';
import 'package:flutter_erp/app/modules/customers/controllers/customer_dialog_controller.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerDialog extends GetWidget<CustomerDialogController> {
  const CustomerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErpDialog(
      title: "Add Customer",
      onSave: () {
        controller.save();
      },
      onCancel: () {
        Get.back();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Obx(() => _imageButton(context)),
          const SizedBox(height: 30),
          Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _formFields(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formFields(BuildContext context) {
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
                initialText: controller.customer.firstName,
                onSaved: (value) {
                  controller.customer.firstName = value;
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: PlusFormField(
                title: "Last Name",
                type: TextInputType.name,
                hintText: "Doe",
                initialText: controller.customer.lastName,
                onSaved: (value) {
                  controller.customer.lastName = value;
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
                Expanded(
                  flex: 40,
                  child: PlusFormField(
                    title: "Email",
                    type: TextInputType.emailAddress,
                    initialText: controller.customer.email,
                    onSaved: (value) {
                      controller.customer.email = value;
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
              flex: 50,
              child: PlusFormField(
                title: "Mobile no.",
                isRequired: true,
                initialText: controller.customer.phoneNumber,
                onSaved: (value) {
                  controller.customer.phoneNumber = value;
                },
                onValidate: ValidationBuilder().phone().build(),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 50,
              child: PlusFormField(
                title: "Date of Birth",
                type: TextInputType.datetime,
                hintText: "dd-mm-yyyy",
                initialText: controller.customer.dob == null
                    ? null
                    : DateFormat("dd-M-yyyy").format(controller.customer.dob!),
                onSaved: (value) {
                  if (value == null) return;
                  try {
                    controller.customer.dob =
                        DateFormat("dd-M-yyyy").parse(value);
                  } catch (e) {
                    return;
                  }
                },
                // onValidate: (value) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 50,
              child: PlusFormField(
                title: "Password",
                onSaved: (value) {
                  if (value?.isEmpty ?? true) {
                    return;
                  }
                  controller.customer.password = value;
                },
                type: TextInputType.visiblePassword,
                onValidate: ValidationBuilder(
                  optional: controller.customer.id != null,
                ).minLength(6).build(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _imageButton(BuildContext context) {
    if (controller.image != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: MemoryImage(controller.image!),
                fit: BoxFit.cover,
              ),
            ),
            child: controller.isLoading.isTrue
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
                controller.customer.photoUrl = null;
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
        controller.updateImage();
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
      child: controller.isLoading.isTrue
          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : const Icon(
              CupertinoIcons.camera_circle_fill,
              size: 60,
              color: Colors.white,
            ),
    );
  }
}
