import 'dart:async';

import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/responses/fetch_response.dart';
import 'package:resource_manager/resource_manager.dart';

class EmployeeRepository extends Repository<Employee> {
  EmployeeRepository() : super(path: "/employee");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Employee get empty =>
      Employee(branchId: Get
          .find<AuthService>()
          .currentBranch
          .id);

  @override
  Future<List<Employee>> fetch({int limit = 100,
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
  Future<FetchResponse<Employee>> fetchWithCount(
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
