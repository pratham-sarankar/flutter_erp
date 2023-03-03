import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';
import 'package:rrule/rrule.dart';

import '../services/auth_service.dart';

class Class extends Resource {
  @override
  final int? id;
  String? title; //
  String? description; //
  String? photoUrl; //
  RecurrenceRule? schedule;
  TimeOfDay? startTime; //
  TimeOfDay? endTime; //
  int? branchId; //
  int? trainerId;

  Employee? trainer;

  Class({
    this.id,
    this.title,
    this.description,
    this.photoUrl,
    this.schedule,
    this.branchId,
    this.endTime,
    this.startTime,
    this.trainerId,
    this.trainer,
  });

  bool get hasPhoto => photoUrl != null;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'photoUrl': photoUrl,
      'branch_id': branchId,
      'trainer_id': trainerId,
      'schedule': schedule?.toString(),
      if (startTime != null)
        'start_time': "${startTime?.hour}:${startTime?.minute}",
      if (endTime != null) 'end_time': "${endTime?.hour}:${endTime?.minute}",
    };
  }

  @override
  Class fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      branchId: map['branch_id'],
      startTime: timeFromString(map['start_time']),
      endTime: timeFromString(map['end_time']),
      schedule: map['schedule'] == null
          ? null
          : RecurrenceRule.fromString(map['schedule']),
      trainer:
          map['trainer'] == null ? null : Employee().fromMap(map['trainer']),
      trainerId: map['trainer_id'],
    );
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(
      columns: [
        "Title",
        "Description",
        "Trainer",
        "Schedule",
        "Starts at",
        "Ends at",
        if (Get.find<AuthService>().canEdit("Classes") ||
            Get.find<AuthService>().canDelete("Classes"))
          "Actions",
      ],
    );
  }

  TimeOfDay? timeFromString(String? value) {
    if (value == null) return null;
    int hour = int.parse(value.split(":")[0]);
    int minute = int.parse(value.split(":")[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    return ResourceRow(
      cells: [
        Cell(data: title ?? "-"),
        Cell(data: description ?? "-"),
        Cell(data: trainer?.getName() ?? "-"),
        Cell(
          data: schedule == null
              ? "-"
              : Get.find<RRuleService>().generateReadableText(schedule!),
        ),
        Cell(data: startTime?.format(Get.context!) ?? "-"),
        Cell(data: endTime?.format(Get.context!) ?? "-"),
        if (Get.find<AuthService>().canEdit("Classes") ||
            Get.find<AuthService>().canDelete("Classes"))
          Cell(
            children: [
              if (Get.find<AuthService>().canEdit("Classes"))
                Cell(
                  isAction: true,
                  data: "Edit",
                  icon: Icons.edit,
                  onPressed: () {
                    controller.updateRow(this);
                  },
                ),
              if (Get.find<AuthService>().canDelete("Classes"))
                Cell(
                  isAction: true,
                  data: "Delete",
                  icon: Icons.delete,
                  onPressed: () {
                    controller.destroyRow(this);
                  },
                ),
            ],
          )
      ],
    );
  }

  String? getPhotoUrl() {
    if (photoUrl == null) return null;
    return FileRepository.instance.getUrl(photoUrl!);
  }

  String get formattedTime {
    if (startTime == null || endTime == null) {
      return "-";
    }
    return "${startTime?.format(Get.context!)} to ${endTime?.format(Get.context!)}";
  }

  @override
  List<Field> getFields() {
    return [
      Field("photoUrl", FieldType.image, label: "Photo"),
      Field("title", FieldType.name, label: "Title"),
      Field("description", FieldType.text, label: "Description"),
      Field("start_time", FieldType.time, label: "Starts At", isRequired: true),
      Field("end_time", FieldType.time, label: "Ends At", isRequired: true),
      Field("schedule", FieldType.recurring,
          label: "Schedule", isRequired: true),
      Field(
        "trainer_id",
        FieldType.dropdown,
        label: "Trainer",
        isRequired: true,
        repository: Get.find<EmployeeRepository>(),
        queries: {'designation_key': 'trainer'},
      )
    ];
  }

  @override
  bool get isEmpty => id == null;

  @override
  String get name => title ?? "";

  @override
  Future<String> fileUploader(Uint8List data) =>
      FileRepository.instance.imageUploader(data);

  @override
  Future<Uint8List> fileDownloader(String url) =>
      FileRepository.instance.imageDownloader(url);

  @override
  String toString() {
    return toMap().toString();
  }
}
