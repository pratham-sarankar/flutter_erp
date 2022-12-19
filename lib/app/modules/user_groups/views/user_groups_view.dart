import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/user_groups_controller.dart';

class UserGroupsView extends GetResponsiveView<UserGroupsController> {
  UserGroupsView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpSettingsScaffold(
      screen: screen,
      path: Routes.USER_GROUPS,
      body: Container(),
    );
  }
}
