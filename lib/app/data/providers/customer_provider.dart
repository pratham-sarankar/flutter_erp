import 'dart:io';

import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class CustomerProvider extends GetConnect {
  Future<List<Customer>> fetchAll() async {
    final token = Get.find<TokenService>().readToken();
    Response response = await get(
      '$host/customer/all',
      headers: {HttpHeaders.authorizationHeader: "bearer $token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    List data = response.body[dataKey];
    List<Customer> customers =
        data.map<Customer>((map) => Customer.fromMap(map)).toList();
    return customers;
  }

  Future<void> insertOne(Customer customer) async {
    return;
  }
}
