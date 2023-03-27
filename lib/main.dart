import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/coupon_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/module_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_mode_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/services/file_service.dart';
import 'package:flutter_erp/app/data/services/ivr_service.dart';
import 'package:flutter_erp/app/data/services/mail_service.dart';
import 'package:flutter_erp/app/data/services/rrule_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:flutter_erp/app/data/utils/themes.dart';
import 'package:flutter_erp/app/modules/classes/controllers/classes_form_controller.dart';
import 'package:flutter_erp/app/modules/courses/controllers/courses_from_controller.dart';
import 'package:flutter_erp/app/modules/customers/controllers/customer_form_controller.dart';
import 'package:flutter_erp/app/modules/employees/controllers/employees_form_controller.dart';
import 'package:flutter_erp/app/modules/payment/controllers/payment_form_controller.dart';
import 'package:flutter_erp/app/modules/subscriptions/controllers/subscription_form_controller.dart';
import 'package:flutter_erp/app/modules/subscriptions/controllers/subscription_table_controller.dart';
import 'package:flutter_erp/widgets/global_widgets/window_scaffold.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/repositories/branch_repository.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  doWhenWindowReady(() {
    final win = appWindow;
    win.maximize();
    win.show();
  });
  if (GetPlatform.isWeb) {
    setPathUrlStrategy();
  }

  // Repositories
  Get.create<BranchRepository>(() => BranchRepository());
  Get.create<PackageRepository>(() => PackageRepository());
  Get.create<CustomerRepository>(() => CustomerRepository());
  Get.create<UserRepository>(() => UserRepository());
  Get.create<ModuleRepository>(() => ModuleRepository());
  Get.create<SubscriptionRepository>(() => SubscriptionRepository());
  Get.create<PaymentModeRepository>(() => PaymentModeRepository());
  Get.create<ClassRepository>(() => ClassRepository());
  Get.create<CouponRepository>(() => CouponRepository());

  //Forms
  Get.lazyPut<PaymentFormController>(() => PaymentFormController(),
      fenix: true);
  Get.lazyPut<SubscriptionFormController>(() => SubscriptionFormController(),
      fenix: true);
  Get.lazyPut<EmployeesFormController>(() => EmployeesFormController(),
      fenix: true);
  Get.lazyPut<CustomerFormController>(() => CustomerFormController(),
      fenix: true);
  Get.lazyPut<CoursesFromController>(() => CoursesFromController(),
      fenix: true);
  Get.lazyPut<ClassesFormController>(() => ClassesFormController(),
      fenix: true);

  Get.put(IVRService());
  Get.put(MailService());
  await Get.putAsync(() => ToastService().init());
  await Get.putAsync(() => AuthService().init());
  Get.create<FileService>(() => FileService());
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
