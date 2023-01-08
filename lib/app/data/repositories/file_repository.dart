import 'dart:typed_data';

import 'package:flutter_erp/app/data/providers/file_provider.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import "package:http/http.dart";

class FileRepository {
  final FileProvider _provider;

  FileRepository._privateConstructor() : _provider = FileProvider();

  static final instance = FileRepository._privateConstructor();

  Future<String> imageUploader(Uint8List data) async {
    return _provider.uploadFile(data);
  }

  Future<Uint8List> imageDownloader(String key) async {
    String url = getUrl(key);
    Response response = await get(Uri.parse(url));
    return response.bodyBytes;
  }

  String getUrl(String key) {
    return "$host/file/$key";
  }
}
