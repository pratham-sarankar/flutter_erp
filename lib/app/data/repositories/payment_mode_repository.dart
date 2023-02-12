import 'package:flutter_erp/app/data/models/payment_mode.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/abstracts/repository.dart';

class PaymentModeRepository extends Repository<PaymentMode> {
  PaymentModeRepository() : super(path: "/payment-mode");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  PaymentMode get empty => PaymentMode();
}
