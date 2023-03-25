import 'package:flutter_erp/app/data/models/call_log.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class CallLogRepository extends Repository<CallLog> {
  CallLogRepository() : super(path: "/call-log");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  CallLog get empty => CallLog();

  @override
  Future<List<CallLog>> fetch(
      {int limit = 100,
      int offset = 0,
      Map<String, dynamic> queries = const {}}) {
    var updatedQueries = {
      ...queries,
      "branch_id": Get.find<AuthService>().currentBranch.id,
    };
    return super.fetch(limit: limit, offset: offset, queries: updatedQueries);
  }
}
