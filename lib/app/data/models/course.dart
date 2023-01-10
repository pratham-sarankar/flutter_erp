import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:resource_manager/resource_manager.dart';

class Course extends Resource<Course> {
  @override
  final int? id;
  String? title;
  String? description;
  String? photoUrl;
  double? duration;

  Course({
    this.id,
    this.title,
    this.description,
    this.photoUrl,
    this.duration,
  });

  bool get hasPhoto => photoUrl != null;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'photoUrl': photoUrl,
      'duration': (duration ?? "").toString(),
    };
  }

  @override
  Course fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      duration: double.parse((map['duration']).toString()),
    );
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(
      columns: ["Title", "Description", "Duration", "Actions"],
    );
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    return ResourceRow(
      cells: [
        Cell(data: title ?? "-"),
        Cell(data: description ?? "-"),
        Cell(data: "$duration hrs"),
        Cell(children: [
          Cell(
            isAction: true,
            data: "Edit",
            icon: Icons.edit,
            onPressed: () {
              controller.updateRow(this);
            },
          ),
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
