import 'package:intl/intl.dart';
import 'package:resource_manager/data/abstracts/resource.dart';

class Coupon extends Resource {
  @override
  int? id;

  @override
  String? name;
  double? discount;
  int? maxUsage;
  DateTime? expireAt;

  Coupon({this.name, this.id, this.discount, this.expireAt, this.maxUsage});

  @override
  fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['id'],
      name: map['name'],
      discount: double.parse(map['discount'].toString()),
      maxUsage: map['maxUsage'] == null
          ? null
          : int.parse(map['maxUsage'].toString()),
      expireAt: map['expireAt'] == null ? null : setExpireAt(map['expireAt']),
    );
  }

  DateTime setExpireAt(String data) {
    var date = DateTime.tryParse(data);
    date ??= DateFormat('d MMM y').parse(data);
    return date;
  }

  String getExpireAt() {
    return expireAt == null ? "-" : DateFormat('d MMM y').format(expireAt!);
  }

  @override
  List<Field> getFields() {
    return [
      Field('name', FieldType.name, label: 'Name', isRequired: true),
      Field('discount', FieldType.number, label: 'Discount', isRequired: true),
      Field('maxUsage', FieldType.number, label: 'Max Usage', isRequired: false),
      Field('expireAt', FieldType.date, label: 'Expire At', isRequired: true),
    ];
  }

  @override
  bool get isEmpty => id == null;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'discount': discount?.toString(),
      'maxUsage': maxUsage?.toString(),
      'expireAt': expireAt == null ? null : getExpireAt(),
    };
  }
}
