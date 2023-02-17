import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
    with StateMixin<List<Subscription>> {
  late RxInt selectedCustomerId;

  @override
  void onInit() {
    selectedCustomerId = RxInt(-1);
    initialize();
    super.onInit();
  }

  void initialize() async {
    var subscriptions = await Get.find<SubscriptionRepository>().fetch();
    change(subscriptions,
        status: subscriptions.isEmpty ? RxStatus.empty() : RxStatus.success());
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
