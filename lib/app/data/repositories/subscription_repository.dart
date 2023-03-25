import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/abstracts/repository.dart';
import 'package:resource_manager/data/responses/fetch_response.dart';

class SubscriptionRepository extends Repository<Subscription> {
  SubscriptionRepository() : super(path: "/subscription");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Subscription get empty =>
      Subscription(branchId: Get.find<AuthService>().currentBranch.id);

  @override
  Future<List<Subscription>> fetch(
      {int limit = 100,
      int offset = 0,
      Map<String, dynamic> queries = const {}}) async {
    var updatedQueries = {
      ...queries,
      "branch_id": Get.find<AuthService>().currentBranch.id,
    };
    var response = await super
        .fetch(limit: limit, offset: offset, queries: updatedQueries);
    return response;
  }

  @override
  Future<FetchResponse<Subscription>> fetchWithCount(
      {int limit = 100,
      int offset = 0,
      Map<String, dynamic> queries = const {}}) async {
    var updatedQueries = {
      ...queries,
      "branch_id": Get.find<AuthService>().currentBranch.id,
    };
    FetchResponse<Subscription> response = await super
        .fetchWithCount(limit: limit, offset: offset, queries: updatedQueries);
    return response;
  }
}
