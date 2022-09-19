import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late RxInt tabIndex;
  late String initialPath;

  @override
  void onInit() {
    initialPath = Routes.CUSTOMERS_TAB;
    tabIndex = Routes.homeTabs.keys.toList().indexOf(initialPath).obs;
    super.onInit();
  }

  void changeTab(int index) {
    tabIndex.value = index;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
