import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheService extends GetxService {
  late final GetStorage _box;

  Future<CacheService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  Future<void> saveData(String key, Map<String, dynamic> data) async {
    return await _box.write(key, data);
  }

  Future<void> deleteData(String key) async {
    return await _box.write(key, null);
  }

  Map<String, dynamic>? readData(String key) {
    return _box.read(key);
  }
}
