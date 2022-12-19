import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/providers/customer_provider.dart';

class CustomerRepository {
  final CustomerProvider _provider;

  CustomerRepository._privateConstructor() : _provider = CustomerProvider();

  static final instance = CustomerRepository._privateConstructor();

  Future<List<Customer>> fetchAll() async {
    List<Customer> results = await _provider.fetchAll();
    return results;
  }

  Future<void> insertOne(Customer customer) async {
    await _provider.insertOne(customer);
    return;
  }
}
