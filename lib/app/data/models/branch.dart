import 'package:resource_manager/resource_manager.dart';

class Branch extends Resource<Branch> {
  @override
  final int? id;

  @override
  String? name;
  String? address;
  String? phoneNumber;
  final int employeesCount;
  final int customersCount;
  final int classesCount;
  final int coursesCount;

  Branch({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.employeesCount = 0,
    this.customersCount = 0,
    this.classesCount = 0,
    this.coursesCount = 0,
  });

  @override
  String toString() {
    return 'Branch{id: $id, name: $name, address: $address, phoneNumber: $phoneNumber, employeesCount: $employeesCount, customersCount: $customersCount, classesCount: $classesCount, coursesCount: $coursesCount}';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'employees_count': employeesCount,
      'customers_count': customersCount,
      'classes_count': classesCount,
      'courses_count': coursesCount,
    };
  }

  bool get isMainBranch => name == "Main branch";

  @override
  Branch fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      employeesCount: map['employees_count'] ?? 0,
      customersCount: map['customers_count'] ?? 0,
      classesCount: map['classes_count'] ?? 0,
      coursesCount: map['courses_count'] ?? 0,
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field(
        "name",
        FieldType.name,
        isRequired: true,
        label: "Name",
      ),
      Field(
        "address",
        FieldType.text,
        label: "Address",
      ),
      Field(
        "phoneNumber",
        FieldType.phoneNumber,
        isRequired: true,
        label: "Phone Number",
      ),
    ];
  }

  @override
  ResourceColumn getResourceColumn() {
    // TODO: implement getResourceColumn
    throw UnimplementedError();
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    // TODO: implement getResourceRow
    throw UnimplementedError();
  }

  @override
  bool get isEmpty => id == null;
}
