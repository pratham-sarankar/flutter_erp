import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/course.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/courses_controller.dart';

class CoursesView extends GetResponsiveView<CoursesController> {
  CoursesView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.COURSES,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Container(
          margin:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ResourceTableView<Course>(
            title: "All Courses",
            repository: Get.find<CourseRepository>(),
          ),
        ),
      ),
    );
  }
}
