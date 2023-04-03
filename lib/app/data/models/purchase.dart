import 'package:flutter_erp/app/data/models/course.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/models/discount.dart';
import 'package:flutter_erp/app/data/models/package.dart';
import 'package:flutter_erp/app/data/models/payment.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/coupon_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_erp/app/data/repositories/payment_mode_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resource_manager/resource_manager.dart';

class Purchase extends Resource {
  @override
  int? id;
  int? customerId;
  int? courseId;
  int? paymentId;
  int? branchId;
  int? modeId;
  DateTime? purchasedAt;
  Customer? customer;
  Course? course;
  Payment? payment;
  Discount? discount;

  double? originalAmount;
  double? discountedAmount;

  Purchase({
    this.id,
    this.customerId,
    this.paymentId,
    this.branchId,
    this.customer,
    this.modeId,
    this.payment,
    this.discountedAmount,
    this.originalAmount,
    this.discount,
    this.course,
    this.courseId,
    this.purchasedAt,
  });

  @override
  Purchase fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'],
      customerId: map['customer_id'],
      courseId: map['course_id'],
      paymentId: map['payment_id'],
      branchId: map['branch_id'],
      modeId: map['mode_id'],
      purchasedAt: map['purchased_at'] != null
          ? DateTime.parse(map['purchased_at'])
          : null,
      customer:
          map['customer'] != null ? Customer().fromMap(map['customer']) : null,
      course: map['course'] != null ? Course().fromMap(map['course']) : null,
      payment:
          map['payment'] != null ? Payment().fromMap(map['payment']) : null,
      discountedAmount: double.parse(map['discounted_amount'].toString()),
      discount: Discount(
        type: DiscountTypeExtension.fromString(map['discount_type']),
        value: double.parse(map['discount_value'].toString()),
      ),
      originalAmount: double.parse(map['original_amount'].toString()),
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field(
        "customer_id",
        FieldType.foreign,
        repository: Get.find<CustomerRepository>(),
        label: "Customer",
      ),
      Field(
        "class_id",
        FieldType.dropdown,
        repository: Get.find<ClassRepository>(),
        label: "Class",
        subField: Field(
          "package_id",
          FieldType.dropdown,
          repository: Get.find<PackageRepository>(),
        ),
      ),
      Field(
        "mode_id",
        FieldType.dropdown,
        repository: Get.find<PaymentModeRepository>(),
        label: "Payment Mode",
      ),
      Field(
        "coupon_id",
        FieldType.dropdown,
        repository: Get.find<CouponRepository>(),
        label: "Coupon Code",
      ),
    ];
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(
      columns: [
        "Customer",
        "Class",
        "Package",
        "Payment Mode",
        "Expiring At",
        "Subscribed At",
      ],
    );
  }

  @override
  ResourceRow getResourceRow(TableController controller) {
    return ResourceRow(
      cells: [
        Cell(
          data: customer?.name,
        ),
        Cell(
          data: payment?.mode?.title,
        ),
      ],
    );
  }

  String getPurchasedAt() {
    return purchasedAt == null
        ? "-"
        : DateFormat('d MMM y').format(purchasedAt!);
  }

  @override
  bool get isEmpty => id == null;

  @override
  String? get name => "";

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "customer_id": customerId,
      "course_id": courseId,
      "branch_id": branchId,
      "payment_id": paymentId,
      "mode_id": modeId,
      "purchased_at": purchasedAt == null
          ? null
          : DateFormat('d MMM y').format(purchasedAt!),
      "discount_value": discount?.value,
      "discount_type": discount?.type.name,
    };
  }

  @override
  String toString() {
    return 'Purchase{id: $id, customerId: $customerId, courseId: $courseId, paymentId: $paymentId, branchId: $branchId, modeId: $modeId, purchasedAt: $purchasedAt, customer: $customer, course: $course, payment: $payment, discount: $discount, originalAmount: $originalAmount, discountedAmount: $discountedAmount}';
  }
}
