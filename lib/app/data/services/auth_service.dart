import 'package:flutter_erp/app/data/models/user.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';

import 'cache_service.dart';

class AuthService extends GetxService {
  late final GetStorage _box;

  Future<AuthService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  bool get isLoggedIn => _box.read(tokenKey) != null;

  Future<void> saveToken(String token) async {
    return await _box.write(tokenKey, token);
  }

  Future<void> logout() async {
    return await _box.write(tokenKey, null);
  }

  String? readToken() {
    return _box.read<String?>(tokenKey);
  }

  Request authenticator(Request request) {
    String? token = readToken();
    if (token != null) {
      request.headers['Authorization'] = "Bearer $token";
    }
    return request;
  }

  User get currentUser {
    var data = Get.find<CacheService>().readData(userKey);
    return User().fromMap(data!);
  }
}
