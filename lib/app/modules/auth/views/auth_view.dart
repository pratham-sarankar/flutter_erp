import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/auth/enums/auth_mode.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Center(
          child: Container(
            width: controller.authMode.value == AuthMode.login ? 300 : 400,
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
              padding: const EdgeInsets.only(
                  right: 30, left: 30, bottom: 40, top: 30),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.authMode.value.text,
                      style: const TextStyle(
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
                    if (controller.authMode.value == AuthMode.register)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: controller.emailController,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (((value?.isEmail) ?? true) ||
                                  (value?.isEmpty ?? true)) {
                                return null;
                              } else {
                                return "Invalid Email";
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.mail, size: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: controller.phoneNumberController,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            validator: (value) {
                              if (value?.isPhoneNumber ?? true) {
                                return null;
                              } else {
                                return "Invalid Phone Number.";
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.phone, size: 20),
                            ),
                          ),
                        ],
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
                                  style: context.theme.textTheme.bodySmall!
                                      .copyWith(
                                    color: Colors.red,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: () {
                      if (controller.authMode.value == AuthMode.register) {
                        controller.register();
                      } else {
                        controller.login();
                      }
                    }, child: Obx(() {
                      if (controller.isLoading.isFalse) {
                        return Text(
                          controller.authMode.value == AuthMode.login
                              ? 'Login'
                              : 'Register',
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
                    })),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: controller.authMode.value == AuthMode.login
                            ? "Don't have an account? "
                            : "Already have an account? ",
                        style: context.theme.textTheme.bodySmall!
                            .copyWith(color: Colors.black, fontSize: 13),
                        children: [
                          TextSpan(
                            text: controller.authMode.value == AuthMode.login
                                ? 'Create one!'
                                : "Login!",
                            style: TextStyle(
                              color: context.theme.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.toggleAuthMode();
                              },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
