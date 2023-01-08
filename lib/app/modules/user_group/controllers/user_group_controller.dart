import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/user_group.dart';
import 'package:flutter_erp/app/data/repositories/user_group_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/user_group_dialog.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class UserGroupController extends GetxController {
  late RxList<UserGroup> groups;
  late RxBool isLoading;
  late RxBool isRefreshing;

  @override
  void onInit() {
    isLoading = true.obs;
    isRefreshing = false.obs;
    fetchUserGroups();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchUserGroups() async {
    var groups = await UserGroupRepository.instance.fetchAll();
    this.groups = RxList(groups);
    isLoading.value = false;
  }

  void createNewGroup() async {
    UserGroup? group = await showCupertinoDialog(
        context: Get.context!, builder: (context) => const UserGroupDialog());
    if (group == null) return;
    try {
      await UserGroupRepository.instance.insertOne(group);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void updateGroup(UserGroup group) async {
    UserGroup? updatedGroup = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => UserGroupDialog(group: group));
    if (updatedGroup == null) return;
    try {
      await UserGroupRepository.instance.updateOne(updatedGroup);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void deleteGroup(UserGroup group) async {
    bool? sure = await showCupertinoDialog(
      context: Get.context!,
      builder: (context) => const ConfirmationDialog(
        message: "Are you sure, you want to delete the designation?",
      ),
    );
    if (!(sure ?? false)) return;
    try {
      await UserGroupRepository.instance.deleteOne(group);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  Future<void> refresh() async {
    if (isRefreshing.value) return;
    isRefreshing.value = true;
    groups.value = await UserGroupRepository.instance.fetchAll();
    isRefreshing.value = false;
  }
}
