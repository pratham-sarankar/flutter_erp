import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/providers/customer_provider.dart';
import 'package:flutter_erp/app/data/utils/abstracts/repository.dart';
import 'package:get/get.dart';

class CustomerRepository implements Repository<Customer> {
  final CustomerProvider _provider;

  CustomerRepository._privateConstructor()
      : _provider = Get.find<CustomerProvider>();

  static final instance = CustomerRepository._privateConstructor();

  @override
  Future<void> insert(Customer customer) {
    return _provider.insert(customer);
  }

  @override
  Future<Customer> fetchOne(int id) {
    return _provider.fetchOne(id);
  }

  @override
  Future<List<Customer>> fetch({int? limit, int? offset}) {
    return _provider.fetch(limit: limit, offset: offset);
  }

  @override
  Future<void> update(Customer branch) {
    return _provider.update(branch);
  }

  @override
  Future<void> destroy(Customer branch) {
    return _provider.destroy(branch);
  }

  @override
  Future<void> destroyMany(List<Customer> customers) {
    return _provider.destroyMany(customers);
  }
}
