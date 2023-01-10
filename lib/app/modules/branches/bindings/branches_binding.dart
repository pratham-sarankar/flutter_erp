import 'package:flutter_erp/app/data/repositories/branch_repository.dart';
import 'package:get/get.dart';

import '../controllers/branches_controller.dart';

class BranchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchRepository>(() => BranchRepository());
    Get.lazyPut<BranchesController>(() => BranchesController());
  }
}
