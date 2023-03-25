import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/repositories/call_log_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/call_log_controller.dart';

class CallLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallLogRepository>(() => CallLogRepository());
    Get.lazyPut<CallLogController>(() => CallLogController());
    Get.lazyPut<TableController<Customer>>(
        () => TableController<Customer>(CustomerRepository()));
  }
}
