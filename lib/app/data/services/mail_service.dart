import 'dart:io';

import 'package:flutter_erp/app/data/utils/keys.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/data.dart';

class MailService extends GetConnect {
  Future<String> sendMail(
      List<String> mailAddresses, String subject, String message) async {
    Response response = await post(
      "$host/mail",
      {
        'to': mailAddresses,
        'subject': subject,
        'message': message,
      },
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return response.body[messageKey];
  }
}
