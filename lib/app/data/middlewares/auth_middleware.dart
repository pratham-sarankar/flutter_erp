import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final tokenService = Get.find<TokenService>();
    return tokenService.hasToken
        ? null
        : const RouteSettings(name: Routes.LOGIN);
  }
}
