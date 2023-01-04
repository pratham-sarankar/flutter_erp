import 'dart:typed_data';

import 'package:flutter_erp/app/data/providers/file_provider.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';

class FileRepository {
  final FileProvider _provider;

  FileRepository._privateConstructor() : _provider = FileProvider();

  static final instance = FileRepository._privateConstructor();

  Future<String> uploadFile(Uint8List data) async {
    return _provider.uploadFile(data);
  }

  String getUrl(String key) {
    return "$host/file/$key";
  }
}
