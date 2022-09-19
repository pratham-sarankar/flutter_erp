part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const HOME_TAB = _Paths.HOME_TAB;
  static const REPORTS_TAB = _Paths.REPORTS_TAB;
  static const CUSTOMERS_TAB = _Paths.CUSTOMERS_TAB;

  static final Map<String, Widget> homeTabs = {
    Routes.HOME_TAB: const HomeTabView(),
    Routes.REPORTS_TAB: const ReportsTabView(),
    Routes.CUSTOMERS_TAB: CustomersTabView(),
  };
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/dashboard';
  static const HOME_TAB = '/';
  static const REPORTS_TAB = '/reports';
  static const CUSTOMERS_TAB = '/customers';
}
