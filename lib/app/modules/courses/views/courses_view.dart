import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/course.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/modules/courses/controllers/courses_table_controller.dart';
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
      appBar: AppBar(
        title: const Text("All Courses"),
        actions: [
          IconButton(
            onPressed: Get.find<CoursesTableController>().refresh,
            icon: const Icon(CupertinoIcons.refresh),
          ),
          IconButton(
            onPressed: Get.find<CoursesTableController>().insertNew,
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body:CoursesTableView(),
    );
  }
}
