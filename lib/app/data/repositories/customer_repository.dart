import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/responses/fetch_response.dart';
import 'package:resource_manager/resource_manager.dart';

class CustomerRepository extends Repository<Customer> {
  CustomerRepository() : super(path: "/customer");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Customer get empty =>
      Customer(branchId: Get
          .find<AuthService>()
          .currentBranch
          .id);

  @override
  Future<List<Customer>> fetch({int limit = 100,
    int offset = 0,
    Map<String, dynamic> queries = const {}}) {
    var updatedQueries = {
      ...queries,
      "branch_id": Get
          .find<AuthService>()
          .currentBranch
          .id,
    };
    return super.fetch(limit: limit, offset: offset, queries: updatedQueries);
  }

  @override
  Future<FetchResponse<Customer>> fetchWithCount(
      {int limit = 100, int offset = 0, Map<String, dynamic> queries = const {
      }}) {
    var updatedQueries = {
      ...queries,
      "branch_id": Get
          .find<AuthService>()
          .currentBranch
          .id,
    };
    return super.fetchWithCount(
        limit: limit, offset: offset, queries: updatedQueries);
  }
}
