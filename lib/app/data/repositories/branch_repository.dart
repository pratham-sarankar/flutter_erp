import 'package:flutter_erp/app/data/models/branch.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

import '../services/auth_service.dart';

class BranchRepository extends Repository<Branch> {
  BranchRepository() : super(path: "/branch");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Branch get empty => Branch();
}
