import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/utils/themes.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
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
