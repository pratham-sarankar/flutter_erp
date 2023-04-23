import 'package:flutter_erp/app/data/repositories/branch_repository.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<BranchRepository>(() => BranchRepository());
  }
}
