import 'package:flutter_erp/app/data/models/customers.dart';
import 'package:flutter_erp/app/data/providers/customer_provider.dart';

class CustomerRepository {
  final CustomerProvider _provider;

  CustomerRepository._privateConstructor() : _provider = CustomerProvider();

  static final instance = CustomerRepository._privateConstructor();

  Future<List<Customer>> getDummyCustomers() async {
    List<Customer> results = await _provider.getDummyCustomers();
    return results;
  }
}
