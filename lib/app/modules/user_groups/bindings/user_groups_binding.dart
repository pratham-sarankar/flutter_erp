import 'package:get/get.dart';

import '../controllers/user_groups_controller.dart';

class UserGroupsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserGroupsController>(
      () => UserGroupsController(),
    );
  }
}
