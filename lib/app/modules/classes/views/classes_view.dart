import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/modules/classes/views/classes_form_view.dart';
import 'package:flutter_erp/app/modules/classes/views/classes_table_view.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/classes_controller.dart';

class ClassesView extends GetResponsiveView<ClassesController> {
  ClassesView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.CLASSES,
      screen: screen,
      body: ClassesTableView(),
    );
  }
}
