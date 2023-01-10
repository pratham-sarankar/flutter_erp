import 'package:flutter_erp/app/data/models/course.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

import '../services/auth_service.dart';

class CourseRepository extends Repository<Course> {
  CourseRepository() : super(path: "/course");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Course get empty => Course();
}
