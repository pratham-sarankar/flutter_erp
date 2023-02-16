import 'package:flutter_erp/app/data/repositories/permission_group_repository.dart';
import 'package:flutter_erp/app/data/repositories/permission_repository.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../controllers/permission_group_controller.dart';

class PermissionGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserGroupController>(() => UserGroupController());
    Get.lazyPut<UserRepository>(() => UserRepository());

    Get.lazyPut<PermissionGroupRepository>(() => PermissionGroupRepository());
    Get.lazyPut<PermissionRepository>(() => PermissionRepository());
  }
}
