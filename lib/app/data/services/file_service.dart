import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_erp/app/data/providers/file_provider.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:http/http.dart';

class FileService extends FileProvider {
  Future<FileService> init() async {
    return this;
  }

  Future<PlatformFile?> pickImage() async {
    var result = await FilePicker.platform
        .pickFiles(allowMultiple: false, dialogTitle: "Pick a image");
    return result?.files.first;
  }

  Future<Uint8List> dataFromNetworkImage(String url) async {
    var response = await get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<String> imageUploader(Uint8List data) async {
    return uploadFile(data);
  }

  Future<Uint8List> imageDownloader(String key) async {
    String url = getUrl(key);
    var response = await get(Uri.parse(url));
    return response.bodyBytes;
  }

  String getUrl(String key) {
    return "$host/file/$key";
  }
}
