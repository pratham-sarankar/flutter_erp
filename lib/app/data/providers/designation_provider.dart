import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class DesignationProvider extends Provider<Designation> {
  DesignationProvider() : super(path: "/designation");

  @override
  Future<Request> authenticator(Request request) async {
    String token = Get.find<TokenService>().readToken();
    request.headers['Authorization'] = "Bearer $token";
    return request;
  }

  @override
  Future destroy(Designation value) async {
    await delete("/${value.id}");
  }

  @override
  Future destroyMany(List<Designation> value) async {
    List ids = value.map((e) => e.id).toList();
    await delete('/', query: {"ids": ids});
  }

  @override
  Future<List<Designation>> fetch({int? limit, int? offset}) async {
    Response response =
        await get('/', query: {"limit": limit, "offset": offset});
    List data = response.body[dataKey];
    return data.map((map) => Designation.fromMap(map)).toList();
  }

  @override
  Future<Designation> fetchOne(int id) async {
    Response response = await get("/$id");
    return Designation.fromMap(response.body);
  }

  @override
  Future insert(Designation value) async {
    await post('/', value.toMap());
  }

  @override
  Future update(Designation value) async {
    await put('/${value.id}', value.toMap());
  }
}
