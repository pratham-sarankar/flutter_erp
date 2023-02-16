import 'package:flutter_erp/app/data/models/permission.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/abstracts/repository.dart';

import '../services/auth_service.dart';

class PermissionRepository extends Repository<Permission> {
  PermissionRepository() : super(path: "/permission");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Permission get empty => Permission();

  @override
  Future update(Permission value) async {
    await put('/${value.groupId}/${value.moduleId}', value.toMap());
  }

  @override
  Future destroy(Permission value) async {
    await delete('/${value.groupId}/${value.moduleId}');
  }
}
