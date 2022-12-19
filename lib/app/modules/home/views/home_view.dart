import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget? builder() {
    return ErpScaffold(
      path: Routes.HOME,
      screen: screen,
      body: Scaffold(
        appBar: AppBar(
          title: const Text('HomeTabView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'HomeTabView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
