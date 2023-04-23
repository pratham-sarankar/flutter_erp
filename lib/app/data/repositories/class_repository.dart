import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/utils/extensions/report_range.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/responses/fetch_response.dart';
import 'package:resource_manager/resource_manager.dart';

import '../services/auth_service.dart';

class ClassRepository extends Repository<Class> {
  ClassRepository() : super(path: "/class");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Class get empty => Class(branchId: Get.find<AuthService>().currentBranch.id);

  Future<ClassSummary> fetchSummary() async {
    final branchId = Get.find<AuthService>().currentBranch.id;

    Response response = await get(
      '/summary?branch_id=$branchId',
    );
    return ClassSummary.fromJson(response.body['data']);
  }

  @override
  Future<List<Class>> fetch(
      {int limit = 100,
      int offset = 0,
      Map<String, dynamic> queries = const {}}) {
    var updatedQueries = {
      ...queries,
      "branch_id": Get.find<AuthService>().currentBranch.id,
    };
    return super.fetch(limit: limit, offset: offset, queries: updatedQueries);
  }

  @override
  Future<FetchResponse<Class>> fetchWithCount(
      {int limit = 100,
      int offset = 0,
      Map<String, dynamic> queries = const {}}) {
    var updatedQueries = {
      ...queries,
      "branch_id": Get.find<AuthService>().currentBranch.id,
    };
    return super
        .fetchWithCount(limit: limit, offset: offset, queries: updatedQueries);
  }

  Future<FetchResponse<Customer>> fetchMembers(int id,
      {String search = ""}) async {
    Response response = await get("/$id/members?search=$search");
    var data = response.body['data']['rows'];
    var count = response.body['data']['count'];
    return FetchResponse(
      data: data.map<Customer>((e) => Customer().fromMap(e)).toList(),
      total: count,
    );
  }
}

class ClassSummary {
  num total = 0;

  ClassSummary();

  ClassSummary.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }
}
