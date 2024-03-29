import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/module_repository.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/services/file_service.dart';
import 'package:flutter_erp/app/data/services/ivr_service.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/utils/themes.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/window_scaffold.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/repositories/branch_repository.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  doWhenWindowReady(() {
    appWindow.maximize();
  });
  if (GetPlatform.isWeb) {
    setPathUrlStrategy();
  }
  Get.create<BranchRepository>(() => BranchRepository());
  Get.lazyPut<BranchRepository>(() => BranchRepository());
  Get.lazyPut<UserRepository>(() => UserRepository());
  Get.lazyPut<ModuleRepository>(() => ModuleRepository());
  Get.put(IVRService());
  await Get.putAsync(() => ToastService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => FileService().init());
  await Get.putAsync(() => RRuleService().init());

  await Get.find<ModuleRepository>().init();
  await Get.find<AuthService>().reloadUser();
  runApp(
    GetMaterialApp(
      title: "Flutter ERP",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
      builder: (context, child) {
        return WindowScaffold(
          child: child!,
        );
      },
    ),
  );
}
