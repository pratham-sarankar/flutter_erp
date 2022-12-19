import 'package:get/get.dart';

class HomeController extends GetxController {
  late RxInt tabIndex;

  @override
  void onInit() {
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
