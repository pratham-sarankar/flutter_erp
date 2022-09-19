import 'package:flutter_erp/app/data/models/customers.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:get/get.dart';

class CustomerTabController extends GetxController {
  late RxList<bool> selectedList;
  late RxBool isLoading;
  late RxList<Customer> customers;

  @override
  void onInit() {
    isLoading = true.obs;
    customers = <Customer>[].obs;
    selectedList = <bool>[].obs;
    _initCustomers();
    super.onInit();
  }

  Future<void> _initCustomers() async {
    customers.value = await CustomerRepository.instance.getDummyCustomers();
    selectedList.value = List.generate(customers.length, (index) => false);
    isLoading.value = false;
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
