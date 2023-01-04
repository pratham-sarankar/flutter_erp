import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class FileService extends GetxService {
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
}
