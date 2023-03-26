import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PaymentFormView extends GetView {
  const PaymentFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentFormView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentFormView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
