import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class BranchProvider extends Provider<Branch> {
  BranchProvider() : super(path: "/branch");

  @override
  Future<Request> authenticator(Request request) async {
    String token = Get.find<TokenService>().readToken();
    request.headers['Authorization'] = "Bearer $token";
    return request;
  }

  @override
  Future<void> insert(Branch value) async {
    await post('/', value.toMap());
  }

  @override
  Future<List<Branch>> fetch({int? limit, int? offset}) async {
    Response response =
        await get('/', query: {"limit": limit, "offset": offset});
    List data = response.body[dataKey];
    return data.map<Branch>((map) => Branch.fromMap(map)).toList();
  }

  @override
  Future<Branch> fetchOne(int id) async {
    Response response = await get('/$id');
    return Branch.fromMap(response.body[dataKey]);
  }

  @override
  Future<void> update(Branch value) async {
    await put('/${value.id}', value.toMap());
  }

  @override
  Future<void> destroy(Branch value) async {
    await delete('/${value.id}');
    return;
  }

  @override
  Future<void> destroyMany(List<Branch> value) async {
    List ids = value.map((branch) => branch.id).toList();
    await delete('/', query: {'ids': ids});
    return;
  }
}
