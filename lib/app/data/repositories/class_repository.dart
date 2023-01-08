import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/providers/class_provider.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class ClassRepository extends Repository<Class> {
  final ClassProvider _provider;

  ClassRepository._privateConstructor() : _provider = Get.find<ClassProvider>();

  static final instance = ClassRepository._privateConstructor();
  @override
  Future destroy(Class value) {
    return _provider.destroy(value);
  }

  @override
  Future destroyMany(List<Class> value) {
    return _provider.destroyMany(value);
  }

  @override
  Future<List<Class>> fetch({int? limit, int? offset}) {
    return _provider.fetch(limit: limit, offset: offset);
  }

  @override
  Future<Class> fetchOne(int id) {
    return _provider.fetchOne(id);
  }

  @override
  Future insert(Class value) {
    return _provider.insert(value);
  }

  @override
  Future update(Class value) {
    return _provider.update(value);
  }

  @override
  Class get empty => Class();
}
