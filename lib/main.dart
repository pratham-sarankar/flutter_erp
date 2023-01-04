import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/services/cache_service.dart';
import 'package:flutter_erp/app/data/services/file_service.dart';
import 'package:flutter_erp/app/data/services/toast_service.dart';
import 'package:flutter_erp/app/data/services/token_service.dart';
import 'package:flutter_erp/app/data/utils/themes.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Get.putAsync(() => ToastService().init());
  await Get.putAsync(() => TokenService().init());
  await Get.putAsync(() => CacheService().init());
  await Get.putAsync(() => FileService().init());
  FlutterError.onError = (details) {};
  doWhenWindowReady(() {
    const initialSize = Size(600, 450);
    appWindow.maximize();
    appWindow.minSize = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
  runApp(
    DevicePreview(
      enabled: false,
      tools: DevicePreview.defaultTools,
      builder: (context) {
        return GetMaterialApp(
          title: "Flutter ERP",
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
