import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/course.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/courses_controller.dart';
import 'courses_table_view.dart';

class CoursesView extends GetResponsiveView<CoursesController> {
  CoursesView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.COURSES,
      screen: screen,
      body:CoursesTableView(),
    );
  }
}
