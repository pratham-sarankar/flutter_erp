import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_erp/app/data/exceptions/api_exception.dart';
import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';

class FileProvider extends GetConnect {
  Future<String> uploadFile(Uint8List data) async {
    Response response = await post(
      "$host/file",
      FormData(
        {
          'file': MultipartFile(
            data,
            filename: DateTime.now().toIso8601String(),
          ),
        },
      ),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return response.body[dataKey];
  }
}
