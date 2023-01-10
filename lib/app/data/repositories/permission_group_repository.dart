import 'package:flutter_erp/app/data/models/permission_group.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/abstracts/repository.dart';

import '../services/auth_service.dart';

class PermissionGroupRepository extends Repository<PermissionGroup> {
  PermissionGroupRepository() : super(path: "/permission-group");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  PermissionGroup get empty => PermissionGroup();
}
