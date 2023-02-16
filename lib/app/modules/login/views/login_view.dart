import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, 0),
                spreadRadius: 1,
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 30, left: 30, bottom: 40, top: 30),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: controller.usernameController,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      prefixIcon: Icon(Icons.person, size: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.passwordController,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if ((value?.length ?? 0) < 6) {
                        return "Should contain at least 6 characters.";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      prefixIcon: Icon(Icons.lock, size: 20),
                    ),
                  ),
                  Obx(
                    () => controller.errorText.value.isNotEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                controller.errorText.value,
                                textAlign: TextAlign.center,
                                style:
                                    context.theme.textTheme.bodySmall!.copyWith(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.login();
                    },
                    child: Obx(
                      () {
                        if (controller.isLoading.isFalse) {
                          return const Text(
                            'Login',
                          );
                        } else {
                          return const SizedBox(
                            height: 13,
                            width: 13,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
