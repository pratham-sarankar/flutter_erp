import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:flutter_erp/app/data/repositories/branch_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/data.dart';
import 'package:resource_manager/widgets/confirmation_dialog.dart';
import 'package:resource_manager/widgets/resource_dialog.dart';

class BranchesController extends GetxController {
  late RxBool isLoading;
  late RxBool isRefreshing;
  late RxList<Branch> branches;

  @override
  void onInit() {
    isLoading = true.obs;
    isRefreshing = false.obs;
    branches = <Branch>[].obs;
    init();
    super.onInit();
  }

  void init() async {
    branches.value = await Get.find<BranchRepository>().fetch();
    isLoading.value = false;
  }

  void createNewBranch() async {
    Branch? branch = await Get.dialog(
        ResourceDialog(resource: Get.find<BranchRepository>().empty));
    if (branch == null) return;
    try {
      await Get.find<BranchRepository>().insert(branch);
    } on ApiException catch (e) {
      Get.find<ToastService>().showErrorToast(e.message);
    }
    await refresh();
  }

  void updateBranch(Branch branch) async {
    Branch? updatedBranch = await Get.dialog(ResourceDialog(resource: branch));
    if (updatedBranch == null) return;
    try {
      await Get.find<BranchRepository>().update(updatedBranch);
    } on ApiException catch (e) {
      Get.find<ToastService>().showErrorToast(e.message);
    }
    await refresh();
  }

  void deleteBranch(Branch branch) async {
    bool sure = await showCupertinoDialog(
      context: Get.context!,
      builder: (context) => const ConfirmationDialog(
          message: "Are you sure you want to delete this branch?"),
    );
    if (!sure) return;
    try {
      await Get.find<BranchRepository>().destroy(branch);
    } on ApiException catch (e) {
      Get.find<ToastService>().showErrorToast(e.message);
    }
    await refresh();
  }

  Future refresh() async {
    isRefreshing.value = true;
    branches.value = await Get.find<BranchRepository>().fetch();
    isRefreshing.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
