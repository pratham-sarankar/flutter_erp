import 'package:flutter_erp/app/data/models/package_duration.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/abstracts/repository.dart';

class PackageDurationRepository extends Repository<PackageDuration> {
  PackageDurationRepository() : super(path: '/duration');

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  PackageDuration get empty => PackageDuration();
}
