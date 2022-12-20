import 'package:get/get.dart';

import '../controllers/user_group_controller.dart';

class UserGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserGroupController>(
      () => UserGroupController(),
    );
  }
}
