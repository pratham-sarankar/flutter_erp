import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:resource_manager/widgets/widgets.dart';

import '../controllers/class_controller.dart';

class ClassView extends GetResponsiveView<ClassController> {
  ClassView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.CLASS,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Container(
          margin:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: TableView<Class>(
            title: "All Classes",
            repository: ClassRepository.instance,
          ),
        ),
      ),
    );
  }
}
