import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:flutter_erp/app/data/providers/branch_provider.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class BranchRepository implements Repository<Branch> {
  final BranchProvider _provider;

  BranchRepository._privateConstructor()
      : _provider = Get.find<BranchProvider>();

  static final instance = BranchRepository._privateConstructor();

  @override
  Future<void> insert(Branch branch) {
    return _provider.insert(branch);
  }

  @override
  Future<Branch> fetchOne(int id) {
    return _provider.fetchOne(id);
  }

  @override
  Future<List<Branch>> fetch({int? limit, int? offset}) {
    return _provider.fetch(limit: limit, offset: offset);
  }

  @override
  Future<void> update(Branch branch) {
    return _provider.update(branch);
  }

  @override
  Future<void> destroy(Branch branch) {
    return _provider.destroy(branch);
  }

  @override
  Future<void> destroyMany(List<Branch> branches) {
    return _provider.destroyMany(branches);
  }

  @override
  Branch get empty => Branch();
}
