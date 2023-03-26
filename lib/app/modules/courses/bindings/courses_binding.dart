import 'package:get/get.dart';

import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/modules/courses/controllers/courses_from_controller.dart';
import 'package:flutter_erp/app/modules/courses/controllers/courses_table_controller.dart';

import '../controllers/courses_controller.dart';

class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoursesFromController>(
      () => CoursesFromController(),
    );
    Get.lazyPut<CoursesTableController>(
      () => CoursesTableController(),
    );
    Get.lazyPut<CoursesController>(() => CoursesController());
    Get.lazyPut<CourseRepository>(() => CourseRepository());
  }
}
