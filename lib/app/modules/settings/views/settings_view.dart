import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetResponsiveView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpSettingsScaffold(
      path: Routes.SETTINGS,
      screen: screen,
      body: Container(),
    );
  }
}
