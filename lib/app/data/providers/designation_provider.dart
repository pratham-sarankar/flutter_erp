import 'dart:io';

import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/designation.dart';
import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class DesignationProvider extends GetConnect {
  Future<Designation> insertOne({required Designation designation}) async {
    Response response = await post('http://$host/designation', {
      "name": designation.name,
    });
    if (response.statusCode != HttpStatus.created) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return Designation.fromMap(data);
  }

  Future<List<Employee>> fetchOneWithEmployees(int id) async {
    final token = Get.find<TokenService>().readToken();
    Response response = await get(
      'http://$host/designation/$id',
      headers: {HttpHeaders.authorizationHeader: "bearer $token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];

    List<Employee> users = data[employeesKey]
        .map<Employee>((map) => Employee.fromMap(map))
        .toList();
    return users;
  }

  Future<List<Designation>> fetchAll() async {
    //TODO: Send token for the authentication
    // final token = Get.find<TokenService>().readToken();
    Response response = await get(
      'http://$host/designation/all',
      headers: {HttpHeaders.authorizationHeader: "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    List data = response.body[dataKey];
    List<Designation> groups =
        data.map<Designation>((map) => Designation.fromMap(map)).toList();
    return groups;
  }

  Future<Designation> updateOne(Designation designation) async {
    Response response =
        await put('http://$host/designation/${designation.id}', {
      "name": designation.name,
    });
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return Designation.fromMap(data);
  }

  Future<void> deleteOne(Designation designation) async {
    Response response =
        await delete('http://$host/designation/${designation.id}');
    if (response.statusCode != HttpStatus.accepted) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return;
  }
}
