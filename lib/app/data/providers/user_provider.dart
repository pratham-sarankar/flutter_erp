import 'dart:io';

import 'package:flutter_erp/app/data/models/Users/user.dart';
import 'package:flutter_erp/app/data/models/users/user_credential.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class UserProvider extends GetConnect {
  Future<UserCredential> login({required UserCredential credential}) async {
    Response response = await post('$host/user/login', credential.toMap());
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return UserCredential(
      user: User.fromMap(data[userKey]),
      token: data[tokenKey],
    );
  }

  Future<List<User>> fetchAll() async {
    // final token = Get.find<TokenService>().readToken();
    //TODO: Send token for the authentication.
    Response response = await get(
      '$host/user/all',
      headers: {'authorization': "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    List data = response.body[dataKey];
    List<User> users = data.map<User>((map) => User.fromMap(map)).toList();
    return users;
  }

  Future<User> insertOne({required UserCredential credential}) async {
    Response response = await post('$host/user', credential.toMap());
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
    return User.fromMap(data);
  }

  Future<User> updateOne({required UserCredential credential}) async {
    // final token = Get.find<TokenService>().readToken();
    //TODO: Send token for the authentication.
    Response response = await put(
      "$host/user/${credential.user.id}",
      credential.toMap(),
      headers: {'authorization': "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return User.fromMap(data);
  }

  Future<void> deleteOne({required User user}) async {
    // final token = Get.find<TokenService>().readToken();
    Response response = await delete(
      "$host/user/${user.id}",
      headers: {'authorization': "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return;
  }

  Future<void> deleteMany({required List<User> users}) async {
    final ids = users.map((e) => e.id.toString()).toList();
    // final token = Get.find<TokenService>().readToken();
    Response response = await delete(
      "$host/user",
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
