import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/columns/table_column.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/resource.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/row/cell.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/row/resource_row.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/table_view.dart';

class Class extends Resource {
  final int? id;
  String? title;
  String? description;
  String? photoUrl;
  double? price;

  Class({
    this.id,
    this.title,
    this.description,
    this.photoUrl,
    this.price,
  });

  bool get hasPhoto => photoUrl != null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'photoUrl': photoUrl,
      'price': price,
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      price: map['price'],
    );
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(
      columns: ["Title", "Description", "Price", "Actions"],
    );
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    return ResourceRow(
      cells: [
        Cell(data: title ?? "-"),
        Cell(data: description ?? "-"),
        Cell(data: (price ?? "-").toString()),
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
}
