import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/Users/user.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/models/user_group.dart';
import 'package:flutter_erp/app/data/models/users/user_credential.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/user_group_repository.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter_erp/app/data/widgets/dialogs/user_dialog.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  late RxList<User> users;
  late RxList<UserGroup> groups;
  late RxBool isLoading;
  late RxBool isRefreshing;
  late RxBool isSelectionMode;

  @override
  void onInit() {
    isLoading = true.obs;
    isRefreshing = false.obs;
    isSelectionMode = false.obs;
    users = <User>[].obs;
    groups = <UserGroup>[].obs;
    init();
    super.onInit();
  }

  Future<void> init() async {
    users.value = await UserRepository.instance.fetchAll();
    groups.value = await UserGroupRepository.instance.fetchAll();
    isLoading.value = false;
  }

  void createNewUser() async {
    isRefreshing.value = true;
    List<Employee> employees = await EmployeeRepository.instance.fetchAll();
    isRefreshing.value = false;
    UserCredential? credential = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => UserDialog(groups: groups, employees: employees));
    if (credential == null || credential.password == null) return;
    try {
      await UserRepository.instance.insertOne(credential: credential);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void updateUser(User user) async {
    UserCredential? updatedCredential = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => UserDialog(user: user, groups: groups));
    if (updatedCredential == null) return;
    print(updatedCredential);
    try {
      await UserRepository.instance.updateOne(credential: updatedCredential);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  void deleteUser(User user) async {
    try {
      bool sure = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => const ConfirmationDialog(
            message: "Are you sure you want to delete the selected user?"),
      );
      if (!sure) return;
      await UserRepository.instance.deleteOne(user);
    } on ApiException catch (e) {
      Get.find<ToastService>().showToast(e.message);
    }
    await refresh();
  }

  Future<void> refresh() async {
    if (isRefreshing.value) return;
    isRefreshing.value = true;
    users.value = await UserRepository.instance.fetchAll();
    groups.value = await UserGroupRepository.instance.fetchAll();
    isRefreshing.value = false;
  }
}
