import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/utils/abstracts/provider.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class ClassProvider extends Provider<Class> {
  ClassProvider() : super(path: "/class");

  @override
  Future destroy(Class value) async {
    await delete('/${value.id}');
  }

  @override
  Future destroyMany(List<Class> value) async {
    List ids = value.map((e) => e.id).toList();
    await delete('/', query: {"ids": ids});
  }

  @override
  Future<List<Class>> fetch({int? limit, int? offset}) async {
    Response response = await get('/?limit=$limit&offset=$offset');
    var data = response.body[dataKey];
    return List.from(data).map((e) => Class.fromMap(e)).toList();
  }

  @override
  Future<Class> fetchOne(int id) async {
    Response response = await get('/$id');
    return Class.fromMap(response.body);
  }

  @override
  Future insert(Class value) async {
    await put('/', value.toMap());
  }

  @override
  Future update(Class value) async {
    await post('/${value.id}', value.toMap());
  }
}
