import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../services/auth_service.dart';

class Class extends Resource {
  @override
  final int? id;
  String? title;
  String? description;
  String? photoUrl;
  double? price;
  int? branchId;

  Class({
    this.id,
    this.title,
    this.description,
    this.photoUrl,
    this.price,
    this.branchId,
  });

  bool get hasPhoto => photoUrl != null;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'photoUrl': photoUrl,
      'price': (price ?? "").toString(),
      'branch_id': branchId,
    };
  }

  @override
  Class fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      price: double.parse((map['price']).toString()),
      branchId: branchId,
    );
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(
      columns: [
        "Title",
        "Description",
        "Price",
        if (Get.find<AuthService>().canEdit("Classes") ||
            Get.find<AuthService>().canDelete("Classes"))
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
        Cell(data: (price ?? "-").toString()),
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

  @override
  List<Field> getFields() {
    return [
      Field("photoUrl", FieldType.image, label: "Photo"),
      Field("title", FieldType.name, label: "Title"),
      Field("description", FieldType.text, label: "Description"),
      Field("price", FieldType.number, label: "Price", isRequired: true),
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
