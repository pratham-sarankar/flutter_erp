import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resource_manager/resource_manager.dart';

import '../services/auth_service.dart';

class Course extends Resource<Course> {
  @override
  final int? id;
  String? title;
  String? description;
  DateTime? startingDate;
  double? price;
  String? photoUrl;
  double? duration;
  int? branchId;

  Course({
    this.id,
    this.title,
    this.description,
    this.photoUrl,
    this.price,
    this.duration,
    this.branchId,
    this.startingDate,
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
      'duration': (duration ?? 0).toString(),
      "starting_date": startingDate == null ? null : getStartingDate(),
      'price': (price ?? 0).toString(),
    };
  }

  String getStartingDate() {
    return startingDate == null
        ? "-"
        : DateFormat('d MMM y').format(startingDate!);
  }

  @override
  Course fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      branchId: map['branch_id'],
      startingDate: map['starting_date'] == null
          ? null
          : DateTime.tryParse(map['starting_date']),
      price:
          map['price'] == null ? null : double.parse((map['price']).toString()),
      duration: map['duration'] == null
          ? null
          : double.parse((map['duration']).toString()),
    );
  }

  String getDateOfBirth() {
    return startingDate == null
        ? "-"
        : DateFormat('d MMM y').format(startingDate!);
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(
      columns: [
        "Title",
        "Description",
        "Duration",
        if (Get.find<AuthService>().canEdit("Courses") ||
            Get.find<AuthService>().canDelete("Courses"))
          "Actions",
      ],
    );
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    return ResourceRow(
      cells: [
        Cell(data: title ?? "-"),
        Cell(data: description ?? "-"),
        Cell(data: "$duration hrs"),
        if (Get.find<AuthService>().canEdit("Courses") ||
            Get.find<AuthService>().canDelete("Courses"))
          Cell(children: [
            if (Get.find<AuthService>().canEdit("Courses"))
              Cell(
                isAction: true,
                data: "Edit",
                icon: Icons.edit,
                onPressed: () {
                  controller.updateRow(this);
                },
              ),
            if (Get.find<AuthService>().canDelete("Courses"))
              Cell(
                isAction: true,
                data: "Delete",
                icon: Icons.delete,
                onPressed: () {
                  controller.destroyRow(this);
                },
              ),
          ])
      ],
    );
  }

  String? getPhotoUrl() {
    if (photoUrl == null) return null;
    return FileRepository.instance.getUrl(photoUrl!);
  }

  @override
  List<Field> getFields() {
    return [
      Field("photoUrl", FieldType.image, label: "Photo"),
      Field("title", FieldType.name, label: "Title"),
      Field("description", FieldType.text, label: "Description"),
      Field("duration", FieldType.number, label: "Duration", isRequired: true),
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
}
