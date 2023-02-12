import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/abstracts/repository.dart';

class SubscriptionRepository extends Repository<Subscription> {
  SubscriptionRepository() : super(path: "/subscription");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Subscription get empty =>
      Subscription(branchId: Get.find<AuthService>().currentBranch.id);
}
