import 'package:flutter_erp/app/data/models/customers.dart';
import 'package:get/get.dart';

class CustomerProvider extends GetConnect {
  Future<List<Customer>> getDummyCustomers() async {
    Response response = await get<List<Customer>>(
      'https://randomuser.me/api/?results=50',
      decoder: (data) {
        List<Customer> results = List.from(data['results'])
            .map((e) => Customer.fromJson(e))
            .toList();
        return results;
      },
    );
    return response.body;
  }
}
