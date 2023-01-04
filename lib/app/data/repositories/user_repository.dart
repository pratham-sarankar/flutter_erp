import 'dart:async';

import 'package:flutter_erp/app/data/models/Users/user.dart';
import 'package:flutter_erp/app/data/models/users/user_credential.dart';
import 'package:flutter_erp/app/data/providers/user_provider.dart';
import 'package:flutter_erp/app/data/services/cache_service.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class UserRepository {
  final UserProvider _provider;

  UserRepository._privateConstructor() : _provider = UserProvider();

  static final instance = UserRepository._privateConstructor();

  User get currentUser {
    var data = Get.find<CacheService>().readData(userKey);
    if (data == null) return User();
    return User.fromMap(data);
  }

  Future<UserCredential> login({required UserCredential credential}) async {
    credential = await _provider.login(credential: credential);
    await Get.find<TokenService>().saveToken(credential.token ?? "");
    await Get.find<CacheService>().saveData(userKey, credential.user.toMap());
    return credential;
  }

  Future<void> logout() async {
    await Get.find<TokenService>().deleteToken();
    await Get.find<CacheService>().deleteData(userKey);
  }

  Future<List<User>> fetchAll() async {
    return await _provider.fetchAll();
  }

  Future<User> insertOne({required UserCredential credential}) async {
    return _provider.insertOne(credential: credential);
  }

  Future<User> updateOne({required UserCredential credential}) async {
    return await _provider.updateOne(credential: credential);
  }

  Future<void> deleteOne(User user) async {
    return await _provider.deleteOne(user: user);
  }

  Future<void> deleteMany(List<User> users) async {
    return await _provider.deleteMany(users: users);
  }
}
