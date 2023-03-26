import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EmployeesFormView extends GetView {
  const EmployeesFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoursesFormView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CoursesFormView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
