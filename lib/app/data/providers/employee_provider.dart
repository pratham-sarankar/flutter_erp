import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class EmployeeProvider extends GetConnect {
  Future<List<Employee>> fetchAll() async {
    // final token = Get.find<TokenService>().readToken();
    //TODO: Send token for the authentication.
    Response response = await get(
      '$host/employee/all',
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
    //TODO: Save token here.
    // var token = data[tokenKey];
    // await Get.find<TokenService>().saveToken(token);
    return Employee.fromMap(data[employeeKey]);
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

  Future<String> uploadImage(Uint8List data) async {
    Response response = await post(
      "$host/image",
      FormData(
        {
          'image': MultipartFile(
            data,
            filename: DateTime.now().toIso8601String(),
          ),
        },
      ),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return response.body[dataKey];
  }
}
