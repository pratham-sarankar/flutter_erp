import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/utils/abstracts/provider.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class CustomerProvider extends Provider<Customer> {
  CustomerProvider() : super(path: "/customer");

  @override
  Future insert(Customer value) async {
    await post('/', value.toMap());
  }

  @override
  Future<List<Customer>> fetch({int? limit, int? offset}) async {
    Response response =
        await get('/', query: {"limit": limit, "offset": offset});
    List data = response.body[dataKey];
    return data.map<Customer>((map) => Customer.fromMap(map)).toList();
  }

  @override
  Future<Customer> fetchOne(int id) async {
    Response response = await get('/$id');
    return Customer.fromMap(response.body[dataKey]);
  }

  @override
  Future<void> update(Customer value) async {
    await put("/${value.id}", value.toMap());
  }

  @override
  Future destroy(Customer value) async {
    await delete('/${value.id}');
    return;
  }

  @override
  Future destroyMany(List<Customer> value) async {
    List ids = value.map((e) => e.id).toList();
    await delete("/", query: {"ids": ids});
  }
}
