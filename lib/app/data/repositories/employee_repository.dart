import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/providers/employee_provider.dart';

class EmployeeRepository {
  final EmployeeProvider _provider;

  EmployeeRepository._privateConstructor() : _provider = EmployeeProvider();

  static final instance = EmployeeRepository._privateConstructor();

  Future<List<Employee>> fetchAll() async {
    return await _provider.fetchAll();
  }

  Future<Employee> insertOne(Employee employee) async {
    return _provider.insertOne(employee: employee);
  }

  Future<Employee> updateOne(Employee employee) async {
    return await _provider.updateOne(employee: employee);
  }

  Future<void> deleteOne(Employee employee) async {
    return await _provider.deleteOne(employee: employee);
  }

  Future<void> deleteMany(List<Employee> employees) async {
    return await _provider.deleteMany(employees: employees);
  }

  Future<String> uploadImage(Uint8List data) async {
    return await _provider.uploadImage(data);
  }
}
