import 'dart:async';

import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/providers/employee_provider.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class EmployeeRepository extends Repository<Employee> {
  final EmployeeProvider _provider;

  EmployeeRepository._privateConstructor()
      : _provider = Get.find<EmployeeProvider>();

  static final instance = EmployeeRepository._privateConstructor();

  @override
  Future insert(Employee value) {
    return _provider.insert(value);
  }

  @override
  Future destroyMany(List<Employee> value) {
    return _provider.destroyMany(value);
  }

  @override
  Future destroy(Employee value) {
    return _provider.destroy(value);
  }

  @override
  Future update(Employee value) {
    return _provider.update(value);
  }

  @override
  Future<Employee> fetchOne(int id) {
    return _provider.fetchOne(id);
  }

  @override
  Future<List<Employee>> fetch({int? limit, int? offset}) async {
    return _provider.fetch(limit: limit, offset: offset);
  }

  @override
  Employee get empty => Employee();
}
