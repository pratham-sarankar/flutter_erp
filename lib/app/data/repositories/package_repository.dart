import 'package:flutter_erp/app/data/models/package.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/abstracts/repository.dart';

class PackageRepository extends Repository<Package> {
  PackageRepository() : super(path: "/package");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Package get empty {
    return Package(classId: int.parse(Get.parameters['id'] ?? "0"));
  }

  @override
  Future<List<Package>> fetch(
      {int limit = 100,
      int offset = 0,
      Map<String, dynamic> queries = const {}}) {
    var updatedQueries = {
      ...queries,
      "classId": Get.parameters['id'] ?? queries["classId"],
    };
    return super.fetch(limit: limit, offset: offset, queries: updatedQueries);
  }
}
