import 'dart:io';

import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class EmployeeProvider extends GetConnect {
  Future<Employee> fetchOne(int id) async {
    // final token = Get.find<TokenService>().readToken();
    //TODO: Send token for the authentication.
    Response response = await get(
      '$host/employee/$id',
      headers: {'authorization': "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return Employee.fromMap(data);
  }

  Future<List<Employee>> search(Employee employee) async {
    Response response = await get('$host/employee/search');
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    List data = response.body[dataKey];
    return data.map<Employee>((e) => Employee.fromMap(e)).toList();
  }

  Future<List<Employee>> fetchAll() async {
    // final token = Get.find<TokenService>().readToken();
    //TODO: Send token for the authentication.
    String url = "$host/employee/";
    Response response = await get(
      url,
      headers: {'authorization': "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    List data = response.body[dataKey];
    List<Employee> employees =
        data.map<Employee>((map) => Employee.fromMap(map)).toList();
    return employees;
  }

  Future<Employee> insertOne({required Employee employee}) async {
    Response response = await post('$host/employee', employee.toMap());
    if (response.statusCode != HttpStatus.created) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return Employee.fromMap(data);
  }

  Future<Employee> updateOne({required Employee employee}) async {
    final token = Get.find<TokenService>().readToken();
    //TODO: Send token for the authentication.
    Response response = await put(
      "$host/employee/${employee.id}",
      employee.toMap(),
      headers: {'authorization': "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return Employee.fromMap(data);
  }

  Future<void> deleteOne({required Employee employee}) async {
    final token = Get.find<TokenService>().readToken();
    Response response = await delete(
      "$host/employee/${employee.id}",
      headers: {'authorization': "bearer $token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return;
  }

  Future<void> deleteMany({required List<Employee> employees}) async {
    final ids = employees.map((e) => e.id.toString()).toList();
    final token = Get.find<TokenService>().readToken();
    Response response = await delete(
      "$host/employee",
      query: {"ids": ids},
      // headers: {'authorization': "bearer $token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return;
  }
}
