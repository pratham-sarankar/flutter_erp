import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
    with StateMixin<List<Subscription>> {
  late RxList<Subscription> selectedList;

  RxBool get canMail => selectedList.isNotEmpty.obs;

  RxBool get canSelectAll => RxBool(selectedList.length != value?.length);

  @override
  void onInit() {
    selectedList = <Subscription>[].obs;
    initialize();
    super.onInit();
  }

  void initialize() async {
    var subscriptions = await Get.find<SubscriptionRepository>().fetch();
    change(subscriptions,
        status: subscriptions.isEmpty ? RxStatus.empty() : RxStatus.success());
  }

  void select(Subscription subscription) async {
    if (selectedList.contains(subscription)) {
      selectedList.remove(subscription);
    } else {
      selectedList.add(subscription);
    }
  }

  void selectAll() async {
    selectedList.value = List.from(value ?? []);
  }

  void deSelectAll() async {
    selectedList.value = [];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool isSelected(Subscription resource) {
    return selectedList.contains(resource);
  }
}
