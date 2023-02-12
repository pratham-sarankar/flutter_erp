import 'package:resource_manager/data/abstracts/resource.dart';

class PackageDuration extends Resource {
  PackageDuration({this.id, this.title, this.days});

  @override
  int? id;
  String? title;
  int? days;

  @override
  PackageDuration fromMap(Map<String, dynamic> map) {
    return PackageDuration(
      id: map['id'],
      title: map['title'],
      days: map['days'],
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field('title', FieldType.text, isRequired: true, label: "Title"),
      Field('days', FieldType.number, isRequired: true, label: "Days"),
    ];
  }

  @override
  bool get isEmpty => id != null;

  @override
  String? get name => title;

  @override
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "days": days,
    };
  }
}
