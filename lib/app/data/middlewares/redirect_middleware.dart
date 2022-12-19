import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RedirectMiddleware extends GetMiddleware {
  final RouteSettings Function(String?) onRedirect;

  RedirectMiddleware(this.onRedirect);

  @override
  RouteSettings redirect(String? route) {
    return onRedirect(route);
  }
}
