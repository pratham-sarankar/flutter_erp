import 'package:flutter_erp/app/data/models/employee.dart';

class Designation {
  int? id;
  String? name;
  int? employeesCount;
  List<Employee> employees;

  Designation({
    this.id,
    this.name,
    this.employeesCount,
    this.employees = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employees_count': employeesCount,
    };
  }

  factory Designation.fromMap(Map<String, dynamic> map) {
    return Designation(
      id: map['id'] as int,
      name: map['name'] as String,
      employeesCount: map['employees_count'] ?? 0,
      employees: List.from(map['employees'] ?? [])
          .map((data) => Employee.fromMap(map))
          .toList(),
    );
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
}
