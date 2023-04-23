import 'package:flutter_erp/app/data/models/payment.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_repository.dart';
import 'package:flutter_erp/app/data/utils/extensions/report_range.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late Rx<PaymentsSummary> paymentSummary;
  late Rx<CustomersSummary> customerSummary;
  late Rx<ClassSummary> classSummary;
  late Rx<CourseSummary> courseSummary;
  late Rx<EmployeeSummary> employeeSummary;
  late Rx<ReportRange> range;

  @override
  void onInit() {
    range = Rx<ReportRange>(ReportRange.weekly);
    paymentSummary = Rx<PaymentsSummary>(PaymentsSummary());
    customerSummary = Rx<CustomersSummary>(CustomersSummary());
    classSummary = Rx<ClassSummary>(ClassSummary());
    courseSummary = Rx<CourseSummary>(CourseSummary());
    employeeSummary = Rx<EmployeeSummary>(EmployeeSummary());
    initData();
    super.onInit();
  }

  void initData() async {
    paymentSummary.value =
        await Get.find<PaymentRepository>().fetchSummary(range.value);
    customerSummary.value =
        await Get.find<CustomerRepository>().fetchSummary(range.value);
    classSummary.value = await Get.find<ClassRepository>().fetchSummary();
    courseSummary.value = await Get.find<CourseRepository>().fetchSummary();
    employeeSummary.value = await Get.find<EmployeeRepository>().fetchSummary();
  }

  List<Payment> get recentPayments => paymentSummary.value.recent;
}
