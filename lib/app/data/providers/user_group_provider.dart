import 'dart:io';

import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/models/user.dart';
import 'package:flutter_erp/app/data/models/user_group.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class UserGroupProvider extends GetConnect {
  Future<UserGroup> insertOne({required UserGroup group}) async {
    Response response = await post('$host/group', {
      "name": group.name,
    });
    if (response.statusCode != HttpStatus.created) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return UserGroup.fromMap(data);
  }

  Future<List<User>> fetchOneWithUsers(int id) async {
    // final token = Get.find<TokenService>().readToken();
    Response response = await get(
      '$host/group/$id',
      headers: {HttpHeaders.authorizationHeader: "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];

    List<User> users =
        data[usersKey].map<User>((map) => User.fromMap(map)).toList();
    return users;
  }

  Future<List<UserGroup>> fetchAll() async {
    //TODO: Send token for the authentication
    // final token = Get.find<TokenService>().readToken();
    Response response = await get(
      '$host/group/all',
      headers: {HttpHeaders.authorizationHeader: "bearer token"},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    List data = response.body[dataKey];
    List<UserGroup> groups =
        data.map<UserGroup>((map) => UserGroup.fromMap(map)).toList();
    return groups;
  }

  Future<UserGroup> updateOne(UserGroup group) async {
    Response response = await put('$host/group/${group.id}', {
      "name": group.name,
    });
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    var data = response.body[dataKey];
    return UserGroup.fromMap(data);
  }

  Future<void> deleteOne(UserGroup group) async {
    Response response = await delete('$host/group/${group.id}');
    if (response.statusCode != HttpStatus.accepted) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return;
  }
}
