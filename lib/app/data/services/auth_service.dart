import 'package:flutter_erp/app/data/models/permission.dart';
import 'package:flutter_erp/app/data/models/user.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:flutter_erp/widgets/global_widgets/sidebar.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resource_manager/widgets/plus_widgets/plus_navigation_rail.dart';

import '../models/branch.dart';

class AuthService extends GetxService {
  late final GetStorage _box;

  Future<AuthService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    // await _box.erase();
    return this;
  }

  Future<void> saveData(String key, Map<String, dynamic> data) async {
    return await _box.write(key, data);
  }

  Future<void> reloadUser() async {
    if (isLoggedIn) {
      var user = await Get.find<UserRepository>().fetchOne(currentUser.id!);
      await saveData(userKey, user.toMap());
    }
  }

  Map<String, dynamic>? readData(String key) {
    return _box.read(key);
  }

  bool get isLoggedIn => _box.read(tokenKey) != null;

  Future<void> saveToken(String token) async {
    return await _box.write(tokenKey, token);
  }

  Future<void> logout() async {
    await _box.erase();
    return;
  }

  String? readToken() {
    return _box.read<String?>(tokenKey);
  }

  Request authenticator(Request request) {
    String? token = readToken();
    if (token != null) {
      request.headers['Authorization'] = "Bearer $token";
    }
    return request;
  }

  Branch get currentBranch {
    var data = readData(branchKey);
    return Branch().fromMap(data!);
  }

  User get currentUser {
    var data = readData(userKey);
    return User().fromMap(data!);
  }

  Future<void> setCurrentBranch(Branch branch) async {
    await saveData(branchKey, branch.toMap());
  }

  bool canView(String moduleName) {
    List<Permission>? permissions = currentUser.permissionGroup?.permissions;
    if (permissions == null) return false;
    var result = permissions.any((permission) {
      return permission.module!.name == moduleName && permission.canView;
    });
    return result;
  }

  bool canAdd(String moduleName) {
    List<Permission>? permissions = currentUser.permissionGroup?.permissions;
    if (permissions == null) return false;
    var result = permissions.any((permission) {
      return permission.module!.name == moduleName && permission.canAdd;
    });
    return result;
  }

  bool canEdit(String moduleName) {
    List<Permission>? permissions = currentUser.permissionGroup?.permissions;
    if (permissions == null) return false;
    var result = permissions.any((permission) {
      return permission.module!.name == moduleName && permission.canEdit;
    });
    return result;
  }

  bool canDelete(String moduleName) {
    List<Permission>? permissions = currentUser.permissionGroup?.permissions;
    if (permissions == null) return false;
    var result = permissions.any((permission) {
      return permission.module!.name == moduleName && permission.canDelete;
    });
    return result;
  }

  List<SideBarGroup> getSideBarGroups() {
    return [
      SideBarGroup(
        title: "ANALYTICS",
        sideBarDestinations: [
          SideBarDestination(
            title: "Dashboard",
            icon: IconlyLight.home,
            boldIcon: IconlyBold.home,
            path: Routes.HOME,
          ),
          if (canView("Branches"))
            SideBarDestination(
              title: "Branches",
              icon: IconlyLight.chart,
              boldIcon: IconlyBold.chart,
              path: Routes.BRANCHES,
            ),
          if (canView("Payments"))
            SideBarDestination(
              title: "Payments",
              icon: IconlyLight.calendar,
              boldIcon: IconlyBold.calendar,
              path: Routes.PAYMENT,
            ),
          if (canView("Subscriptions"))
            SideBarDestination(
              title: "Subscriptions",
              icon: IconlyLight.notification,
              boldIcon: IconlyBold.notification,
              path: Routes.SUBSCRIPTIONS,
            ),
        ],
      ),
      SideBarGroup(
        title: "MAIN MENU",
        sideBarDestinations: [
          if (canView("Employees"))
            SideBarDestination(
              title: "Employees",
              icon: IconlyLight.user2,
              boldIcon: IconlyBold.user2,
              path: Routes.EMPLOYEES,
            ),
          if (canView("Customers"))
            SideBarDestination(
              title: "Customers",
              icon: IconlyLight.user3,
              boldIcon: IconlyBold.user3,
              path: Routes.CUSTOMERS,
            ),
          if (canView("Classes"))
            SideBarDestination(
              title: "Classes",
              icon: IconlyLight.calendar,
              boldIcon: IconlyBold.calendar,
              path: Routes.CLASSES,
            ),
          if (canView("Courses"))
            SideBarDestination(
              title: "Courses",
              icon: IconlyLight.document,
              boldIcon: IconlyBold.document,
              path: Routes.COURSES,
            ),
          if (canView("Courses"))
            SideBarDestination(
              title: "Call Logs",
              icon: IconlyLight.call,
              boldIcon: IconlyBold.call,
              path: Routes.CALL_LOG,
            ),
        ],
      ),
      SideBarGroup(
        title: "OTHERS",
        sideBarDestinations: [
          SideBarDestination(
            title: "Settings",
            icon: IconlyLight.setting,
            boldIcon: IconlyBold.setting,
            path: Routes.SETTINGS,
          ),
        ],
      ),
    ];
  }

  List<PlusNavigationRailItem> getSettingsTabs() {
    return [
      PlusNavigationRailItem(
        label: 'My Profile',
        path: Routes.PROFILE,
      ),
      if (canView("Users"))
        PlusNavigationRailItem(
          label: 'Users',
          path: Routes.USERS,
        ),
      if (canView("Permission Groups"))
        PlusNavigationRailItem(
          label: 'Permission Groups',
          path: Routes.PERMISSION_GROUPS,
        ),
      if (canView("Designations"))
        PlusNavigationRailItem(
          label: 'Designations',
          path: Routes.DESIGNATIONS,
        ),
      if (canView("Designations"))
        PlusNavigationRailItem(
          label: 'Coupons',
          path: Routes.COUPON,
        ),
    ];
  }
}
