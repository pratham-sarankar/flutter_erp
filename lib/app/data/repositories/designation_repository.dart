import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/providers/designation_provider.dart';

class DesignationRepository {
  final DesignationProvider _provider;

  DesignationRepository._privateConstructor()
      : _provider = DesignationProvider();

  static final instance = DesignationRepository._privateConstructor();

  Future<Designation> insertOne(Designation designation) async {
    return await _provider.insertOne(designation: designation);
  }

  Future<List<Designation>> fetchAll() async {
    return await _provider.fetchAll();
  }

  Future<List<Employee>> fetchOneWithEmployees(int id) async {
    return await _provider.fetchOneWithEmployees(id);
  }

  Future<Designation> updateOne(Designation designation) async {
    return await _provider.updateOne(designation);
  }

  Future<void> deleteOne(Designation designation) async {
    return await _provider.deleteOne(designation);
  }
}
