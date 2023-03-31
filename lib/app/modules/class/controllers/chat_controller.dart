import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/widgets/dialogs/mail_dialog.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/responses/fetch_response.dart';

class ChatController extends GetxController with StateMixin<List<Customer>> {
  late RxList<Customer> selectedCustomers;

  @override
  void onInit() {
    initialize();
    selectedCustomers = <Customer>[].obs;
    super.onInit();
  }

  void initialize() async {
    change([], status: RxStatus.loading());
    int id = int.parse(Get.parameters['id'].toString());
    FetchResponse<Customer> response =
        await Get.find<ClassRepository>().fetchMembers(id);
    change(
      response.data,
      status: response.total == 0 ? RxStatus.empty() : RxStatus.success(),
    );
  }

  void select(Customer customer) {
    if (selectedCustomers.contains(customer)) {
      selectedCustomers.remove(customer);
    } else {
      selectedCustomers.add(customer);
    }
  }

  void search(String key) async {
    change([], status: RxStatus.loading());
    int id = int.parse(Get.parameters['id'].toString());
    FetchResponse<Customer> response =
        await Get.find<ClassRepository>().fetchMembers(id, search: key);
    change(
      response.data,
      status: response.total == 0 ? RxStatus.empty() : RxStatus.success(),
    );
  }

  void mail() async {
    List<String> mails = selectedCustomers
        .where((e) => e.email != null)
        .map<String>((e) => e.email!)
        .toList();
    await Get.dialog(MailDialog(initialMails: mails));
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
