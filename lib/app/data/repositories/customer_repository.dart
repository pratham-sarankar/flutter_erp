import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/utils/extensions/report_range.dart';
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
      Customer(branchId: Get.find<AuthService>().currentBranch.id);

  Future<CustomersSummary> fetchSummary(ReportRange range) async {
    final branchId = Get.find<AuthService>().currentBranch.id;
    final rangeString = range.toString().split('.').last;

    Response response = await get(
      '/summary?range=$rangeString&branch_id=$branchId',
    );
    return CustomersSummary.fromJson(response.body['data']);
  }

  @override
  Future<List<Customer>> fetch(
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
  Future<FetchResponse<Customer>> fetchWithCount(
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
}

class CustomersSummary {
  num total = 0;
  num difference = 0;
  List<Customer> recent = [];
  List<num> monthlyData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  CustomersSummary();

  CustomersSummary.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    difference = json['difference'];
    recent =
        json['recent'].map<Customer>((e) => Customer().fromMap(e)).toList();
    monthlyData = List<num>.from(json['monthly']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = total;
    data['percentage'] = difference;
    return data;
  }
}
