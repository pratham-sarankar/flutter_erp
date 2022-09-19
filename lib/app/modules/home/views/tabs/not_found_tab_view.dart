import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NotFoundTabView extends GetView {
  const NotFoundTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotFoundTabView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotFoundTabView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
