import 'package:flutter_erp/app/data/models/course.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/responses/fetch_response.dart';
import 'package:resource_manager/resource_manager.dart';

import '../services/auth_service.dart';

class CourseRepository extends Repository<Course> {
  CourseRepository() : super(path: "/course");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Course get empty =>
      Course(branchId: Get
          .find<AuthService>()
          .currentBranch
          .id);

  Future<CourseSummary> fetchSummary() async {
    final branchId = Get
        .find<AuthService>()
        .currentBranch
        .id;

    Response response = await get(
      '/summary?branch_id=$branchId',
    );
    return CourseSummary.fromJson(response.body['data']);
  }

  @override
  Future<List<Course>> fetch({int limit = 100,
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
  Future<FetchResponse<Course>> fetchWithCount({int limit = 100,
    int offset = 0,
    Map<String, dynamic> queries = const {}}) async {
    var updatedQueries = {
      ...queries,
      "branch_id": Get
          .find<AuthService>()
          .currentBranch
          .id,
    };
    FetchResponse<Course> response = await super
        .fetchWithCount(limit: limit, offset: offset, queries: updatedQueries);
    return response;
  }
}

class CourseSummary {
  num total = 0;

  CourseSummary();

  CourseSummary.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }
}
