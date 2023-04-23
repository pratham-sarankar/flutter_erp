import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/models/payment.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/utils/extensions/report_range.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/responses/fetch_response.dart';
import 'package:resource_manager/resource_manager.dart';

class PaymentRepository extends Repository<Payment> {
  PaymentRepository() : super(path: "/payment");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Payment get empty =>
      Payment(branchId: Get.find<AuthService>().currentBranch.id);

  Future<PaymentsSummary> fetchSummary(ReportRange range) async {
    final branchId = Get.find<AuthService>().currentBranch.id;
    final rangeString = range.toString().split('.').last;

    Response response = await get(
      '/summary?range=$rangeString&branch_id=$branchId',
    );
    return PaymentsSummary.fromJson(response.body['data']);
  }

  @override
  Future<List<Payment>> fetch(
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
  Future<FetchResponse<Payment>> fetchWithCount(
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

class PaymentsSummary {
  late num total;
  late num percentage;
  late List<Payment> recent;
  late List<num> monthlyData;

  PaymentsSummary({
    this.total = 0,
    this.percentage = 0,
    this.recent = const [],
    this.monthlyData = const [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  });

  factory PaymentsSummary.fromJson(Map<String, dynamic> json) {
    return PaymentsSummary(
      total: json['total'] ?? 0,
      percentage: json['percentage'] ?? 0,
      recent: (json['recent'] as List)
          .map<Payment>((e) => Payment().fromMap(e))
          .toList(),
      monthlyData: List<num>.from(json['monthly']),
    );
  }
}
