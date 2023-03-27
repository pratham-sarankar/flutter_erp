import 'package:flutter/cupertino.dart';
import 'package:flutter_erp/app/data/models/course.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/branch_repository.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../data/models/class.dart';
import '../../../data/models/employee.dart';

class CoursesFromController extends GetxController {
  late GlobalKey<FormState> formKey;
  // late Subscription subscription;
  late Course course;
  late RxBool isLoading;
  late RxString error;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    course = Course(branchId: Get.find<AuthService>().currentBranch.id);
    isLoading = false.obs;
    error = "".obs;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void submit() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState!.save();
        await Get.find<CourseRepository>().insert(course);
        Get.back(result: true);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
      rethrow;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}