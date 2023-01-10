import 'package:flutter_erp/app/data/models/payment.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class PaymentRepository extends Repository<Payment> {
  PaymentRepository() : super(path: "/payment");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Payment get empty => Payment();
}
