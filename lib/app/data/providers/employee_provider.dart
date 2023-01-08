import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class EmployeeProvider extends Provider<Employee> {
  EmployeeProvider() : super(path: "/employee");

  @override
  Future<Request> authenticator(Request request) async {
    String token = Get.find<TokenService>().readToken();
    request.headers['Authorization'] = "Bearer $token";
    return request;
  }

  @override
  Future destroy(Employee value) async {
    await delete('/${value.id}');
  }

  @override
  Future destroyMany(List<Employee> value) async {
    List ids = value.map((e) => e.id).toList();
    await delete('/', query: {"ids": ids});
  }

  @override
  Future<List<Employee>> fetch({int? limit, int? offset}) async {
    Response response = await get("/?limit=$limit&offset=$offset");
    var data = response.body[dataKey];
    return List.from(data).map((map) => Employee.fromMap(map)).toList();
  }

  @override
  Future insert(Employee value) async {
    await post("/", value.toMap());
  }

  @override
  Future update(Employee value) async {
    await put("/${value.id}", value.toMap());
  }

  @override
  Future<Employee> fetchOne(int id) async {
    Response response = await get("/$id");
    return Employee.fromMap(response.body);
  }
}
