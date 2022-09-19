import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ReportsTabView extends GetView {
  const ReportsTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReportsTabView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ReportsTabView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
