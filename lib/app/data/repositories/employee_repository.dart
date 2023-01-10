import 'dart:async';

import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class EmployeeRepository extends Repository<Employee> {
  EmployeeRepository() : super(path: "/employee");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Employee get empty => Employee();
}
