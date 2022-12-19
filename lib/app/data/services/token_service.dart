import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenService extends GetxService {
  late final GetStorage _box;

  Future<TokenService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  bool get hasToken => _box.read(tokenKey) != null;

  Future<void> saveToken(String token) async {
    return await _box.write(tokenKey, token);
  }

  String readToken() {
    return "";
    // return _box.read(tokenKey);
  }
}
