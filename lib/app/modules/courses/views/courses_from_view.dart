import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_date_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_recurring_form_field.dart';

import 'package:flutter_erp/widgets/form_field_widgets/erp_text_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_time_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/image_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/trainer_selection_form_field.dart';

import 'package:get/get.dart';

import '../controllers/courses_from_controller.dart';

class CoursesFormView extends GetView<CoursesFromController> {
  const CoursesFormView({Key? key}) : super(key: key);

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
              controller.isUpdating ? "Update Course" : "Add Course",
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
                    const SizedBox(height: 22),
                    ImageFormField(
                      initialValue: controller.course.photoUrl,
                      title: "Image",
                      onSaved: (value) {
                        controller.course.photoUrl =
                            (value?.isEmpty ?? true) ? null : value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ErpTextFormField(
                      title: "Title",
                      initialValue: controller.course.title,
                      isRequired: true,
                      onSaved: (value) {
                        controller.course.title =
                            (value?.isEmpty ?? true) ? null : value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ErpTextFormField(
                      title: "Description",
                      initialValue: controller.course.description,
                      onSaved: (value) {
                        controller.course.description =
                            (value?.isEmpty ?? true) ? null : value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ErpTextFormField(
                      title: "Batch no.",
                      initialValue: controller.course.batchNo?.toString() ?? "",
                      isRequired: false,
                      onSaved: (value) {
                        controller.course.batchNo = int.parse(value!);
                      },
                      onValidate: (value) {
                        try {
                          double.parse(value ?? "");
                          return null;
                        } catch (e) {
                          return "Invalid Batch no.";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ErpDateFormField(
                          initialValue: controller.course.startingDate,
                          title: "Start Date",
                          isRequired: true,
                          onSaved: (value) {
                            controller.course.startingDate = value;
                          },
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ErpTextFormField(
                            title: "Duration (in hours)",
                            initialValue:
                                controller.course.duration?.toString() ?? "",
                            isRequired: true,
                            onSaved: (value) {
                              controller.course.duration = double.parse(value!);
                            },
                            onValidate: (value) {
                              try {
                                double.parse(value ?? "");
                                return null;
                              } catch (e) {
                                return "Invalid Duration";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ErpTextFormField(
                      title: "Price",
                      initialValue: controller.course.price?.toString() ?? "",
                      isRequired: true,
                      onSaved: (value) {
                        controller.course.price = double.parse(value!);
                      },
                      onValidate: (value) {
                        try {
                          double.parse(value ?? "");
                          return null;
                        } catch (e) {
                          return "Invalid Price";
                        }
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
