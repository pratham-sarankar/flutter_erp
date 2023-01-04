import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:flutter_erp/app/data/repositories/branch_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/branch_dialog.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/confirmation_dialog.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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
    branches.value = await BranchRepository.instance.fetch();
    isLoading.value = false;
  }

  void createNewBranch() async {
    Branch? branch = await showCupertinoDialog(
        context: Get.context!, builder: (context) => const BranchDialog());
    if (branch == null) return;
    try {
      await BranchRepository.instance.insert(branch);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void updateBranch(Branch branch) async {
    Branch? updatedBranch = await showCupertinoDialog(
      context: Get.context!,
      builder: (context) => BranchDialog(branch: branch),
    );
    if (updatedBranch == null) return;
    try {
      await BranchRepository.instance.update(updatedBranch);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
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
      await BranchRepository.instance.destroy(branch);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  Future refresh() async {
    isRefreshing.value = true;
    branches.value = await BranchRepository.instance.fetch();
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
