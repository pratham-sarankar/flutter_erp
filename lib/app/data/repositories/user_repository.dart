import 'dart:async';
import 'dart:convert';

import 'package:flutter_erp/app/data/models/user.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/data/abstracts/repository.dart';

class UserRepository extends Repository<User> {
  UserRepository() : super(path: "/user");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  Future<void> login(String username, String password) async {
    Response response = await post(
      "/login",
      {"username": username, "password": password},
    );
    var data = response.body[dataKey];
    var user = data[userKey];
    var branch = user[employeeKey][branchKey];
    var token = data[tokenKey];

    await Get.find<AuthService>().saveToken(token);
    await Get.find<AuthService>().saveData(userKey, user);
    await Get.find<AuthService>().saveData(branchKey, branch);
  }

  Future<void> updatePassword(String password, String newPassword) async {
    Response response = await put(
      "/password",
      jsonEncode({"password": password, "newPassword": newPassword}),
    );
    var data = response.body[dataKey];
    var user = data[userKey];
    var token = data[tokenKey];
    await Get.find<AuthService>().saveToken(token);
    await Get.find<AuthService>().saveData(userKey, user);
  }

  @override
  User get empty => User();

  @override
  Future<List<User>> fetch(
      {int limit = 100,
      int offset = 0,
      Map<String, dynamic> queries = const {}}) {
    var updatedQueries = {
      ...queries,
      "branch_id": Get.find<AuthService>().currentBranch.id,
    };
    return super.fetch(limit: limit, offset: offset, queries: updatedQueries);
  }
}
