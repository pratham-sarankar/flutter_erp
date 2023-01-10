import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:resource_manager/resource_manager.dart';

class Designation extends Resource {
  @override
  int? id;
  @override
  String? name;
  int? employeesCount;
  List<Employee> employees;

  Designation({
    this.id,
    this.name,
    this.employeesCount,
    this.employees = const [],
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employees_count': employeesCount,
    };
  }

  @override
  String toString() {
    return 'Designation{id: $id, name: $name, employeesCount: $employeesCount}';
  }

  String getName() {
    return name ?? "-";
  }

  int getEmployeesCount() {
    return employeesCount ?? 0;
  }

  bool get hasEmployees => (employeesCount ?? 0) > 0;

  @override
  Designation fromMap(Map<String, dynamic> map) {
    return Designation(
      id: map['id'] as int,
      name: map['name'] as String,
      employeesCount: map['employees_count'] ?? 0,
      employees: List.from(map['employees'] ?? [])
          .map((data) => Employee().fromMap(map))
          .toList(),
    );
  }

  @override
  List<Field> getFields() {
    // TODO: implement getFields
    throw UnimplementedError();
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
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();
}
