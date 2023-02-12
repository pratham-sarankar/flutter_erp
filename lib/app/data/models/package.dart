import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/repositories/package_duration_repository.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/abstracts/resource.dart';

class Package extends Resource {
  @override
  int? id;
  int? classId;
  int? durationId;
  String? title;
  double? price;

  double? discount;
  Class? classDetails;

  Package({
    this.id,
    this.classId,
    this.durationId,
    this.title,
    this.price,
    this.discount,
    this.classDetails,
  });

  @override
  Package fromMap(Map<String, dynamic> map) {
    return Package(
      id: map['id'],
      classId: map['class_id'],
      durationId: map['duration_id'],
      title: map['title'],
      price: double.parse((map['price'] ?? 0).toString()),
      discount: double.parse((map['discount'] ?? 0).toString()),
      classDetails: map['class'] == null ? null : Class().fromMap(map['class']),
    );
  }

  Duration durationFromTime(String time) {
    var values = time.split(":").map((e) => int.parse(e)).toList();
    return Duration(
      hours: values[0],
      seconds: values[1],
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field("title", FieldType.name, label: "Title", isRequired: true),
      Field("price", FieldType.number, label: "Price", isRequired: true),
      Field("discount", FieldType.number, label: "Discount", isRequired: false),
      Field(
        "duration_id",
        FieldType.dropdown,
        repository: Get.find<PackageDurationRepository>(),
        label: "Duration",
        isRequired: true,
      ),
    ];
  }

  @override
  bool get isEmpty => id == null;

  @override
  String? get name => title;

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "discount": discount,
      'class_id': classId,
      'duration_id': durationId,
    };
  }
}
