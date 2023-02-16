import 'package:resource_manager/data/abstracts/resource.dart';

class PaymentMode extends Resource {
  @override
  int? id;
  String? title;

  PaymentMode({
    this.id,
    this.title,
  });

  @override
  PaymentMode fromMap(Map<String, dynamic> map) {
    return PaymentMode(
      id: map['id'],
      title: map['title'],
    );
  }

  @override
  List<Field> getFields() {
    return [];
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
    };
  }
}
