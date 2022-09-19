import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/home/views/tabs/customer_tab_view.dart';
import 'package:flutter_erp/app/modules/home/views/tabs/home_tab_view.dart';
import 'package:flutter_erp/app/modules/home/views/tabs/reports_tab_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      title: 'Dashboard',
    ),
  ];
}
