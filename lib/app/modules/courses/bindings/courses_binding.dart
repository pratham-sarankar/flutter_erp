import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:get/get.dart';

import '../controllers/courses_controller.dart';

class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoursesController>(() => CoursesController());
    Get.lazyPut<CourseRepository>(() => CourseRepository());
  }
}
