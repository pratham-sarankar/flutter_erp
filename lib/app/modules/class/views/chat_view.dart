import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/subscription.dart';
import 'package:flutter_erp/app/data/repositories/subscription_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:flutter_erp/app/modules/class/controllers/chat_controller.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:resource_manager/resource_manager.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.selectedCustomerId.value != -1) {
          return Container();
        }
        return Card(
          child: controller.obx(
            (state) {
              if (state == null) {
                return const Center(child: Text("No Data"));
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
