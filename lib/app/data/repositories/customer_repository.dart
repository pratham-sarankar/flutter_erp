import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class CustomerRepository extends Repository<Customer> {
  CustomerRepository() : super(path: "/customer");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Customer get empty => Customer();
}
