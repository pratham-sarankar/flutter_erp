import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class CustomerProvider extends Provider<Customer> {
  CustomerProvider() : super(path: "/customer");

  @override
  Future<Request> authenticator(Request request) async {
    String token = Get.find<TokenService>().readToken();
    request.headers['Authorization'] = "Bearer $token";
    return request;
  }

  @override
  Future insert(Customer value) async {
    await post('/', value.toMap());
  }

  @override
  Future<List<Customer>> fetch({int? limit, int? offset}) async {
    Response response = await get('/?limit=$limit&offset=$offset');
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
