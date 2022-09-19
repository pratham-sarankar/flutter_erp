import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DashboardTabView extends GetView {
  const DashboardTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardTabView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DashboardTabView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
