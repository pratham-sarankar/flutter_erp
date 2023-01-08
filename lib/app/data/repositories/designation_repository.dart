import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/providers/designation_provider.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class DesignationRepository extends Repository<Designation> {
  final DesignationProvider _provider;

  DesignationRepository._privateConstructor()
      : _provider = Get.find<DesignationProvider>();

  static final instance = DesignationRepository._privateConstructor();

  @override
  Future<void> insert(Designation value) {
    return _provider.insert(value);
  }

  @override
  Future<Designation> fetchOne(int id) {
    return _provider.fetchOne(id);
  }

  @override
  Future<List<Designation>> fetch({int? limit, int? offset}) {
    return _provider.fetch(limit: limit, offset: offset);
  }

  @override
  Future<void> update(Designation value) {
    return _provider.update(value);
  }

  @override
  Future<void> destroy(Designation value) {
    return _provider.destroy(value);
  }

  @override
  Future<void> destroyMany(List<Designation> value) {
    return _provider.destroyMany(value);
  }

  @override
  Designation get empty => Designation();
}
