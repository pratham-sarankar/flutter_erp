import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/services/file_service.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_recurring_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_time_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_dropdown_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_text_form_field.dart';
import 'package:flutter_erp/widgets/form_field_widgets/image_form_field.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_dialog.dart';

import 'package:get/get.dart';

import '../controllers/classes_form_controller.dart';

class ClassesFormView extends StatelessWidget {
  const ClassesFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ClassesFormController(),
      builder: (controller) {
        return ErpDialog(
          title: controller.getTitle(),
          onCancel: () {
            Get.back();
          },
          onSave: () async {
            controller.saveAndClose();
          },
          child: Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      ImageFormField(
                        title: 'Image',
                        initialValue: controller.getValue()?.photoUrl,
                        uploader: Get.find<FileService>().imageUploader,
                        downloader: Get.find<FileService>().imageDownloader,
                        onSaved: (photoUrl) {
                          controller.updateClass((oldValue) {
                            oldValue.photoUrl = photoUrl;
                            return oldValue;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ErpTextFormField(
                        title: 'Title',
                        initialValue: controller.getValue()?.title,
                        isRequired: true,
                        onSaved: (title) {
                          controller.updateClass((oldValue) {
                            oldValue.title = title;
                            return oldValue;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ErpTextFormField(
                        title: 'Description',
                        initialValue: controller.getValue()?.description,
                        isMultiline: true,
                        onSaved: (description) {
                          controller.updateClass((oldValue) {
                            oldValue.description = description;
                            return oldValue;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ErpTimeFormField(
                              title: "Start Time",
                              isRequired: true,
                              initialValue: controller.getValue()?.startTime,
                              onSaved: (value) {
                                controller.updateClass((oldValue) {
                                  oldValue.startTime = value;
                                  return oldValue;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ErpTimeFormField(
                              title: "End Time",
                              isRequired: true,
                              initialValue: controller.getValue()?.endTime,
                              onSaved: (value) {
                                controller.updateClass((oldValue) {
                                  oldValue.endTime = value;
                                  return oldValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: Get.find<EmployeeRepository>()
                            .fetch(queries: {'designation_key': 'trainer'}),
                        builder: (context, snapshot) {
                          return ErpDropDownFormField(
                            title: "Select Trainer",
                            initialValue: controller.getValue()?.trainerId,
                            isRequired: true,
                            onSaved: (value) {
                              controller.updateClass((oldValue) {
                                oldValue.trainerId = value;
                                return oldValue;
                              });
                            },
                            items: [
                              ...(snapshot.data ?? []).map(
                                (employee) {
                                  return DropdownMenuItem<int>(
                                    value: employee.id,
                                    child: Text(
                                      employee.getName(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      ErpRecurringFormField(
                        title: "Schedule",
                        initialValue: controller.getValue()?.schedule,
                        isRequired: true,
                        onSaved: (value) {
                          controller.updateClass((oldValue) {
                            oldValue.schedule = value;
                            return oldValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
