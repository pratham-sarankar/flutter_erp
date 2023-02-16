import 'package:flutter_erp/app/data/models/permission.dart';
import 'package:get/get.dart';

class UserGroupController extends GetxController {
  late List<Permission>? permissions;

  @override
  void onInit() {
    permissions = [];
  }
}
