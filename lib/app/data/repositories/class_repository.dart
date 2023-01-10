import 'package:flutter_erp/app/data/models/class.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

import '../services/auth_service.dart';

class ClassRepository extends Repository<Class> {
  ClassRepository() : super(path: "/class");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Class get empty => Class();
}
