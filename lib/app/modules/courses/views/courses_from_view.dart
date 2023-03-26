import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CoursesFromView extends GetView {
  const CoursesFromView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoursesFromView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CoursesFromView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
