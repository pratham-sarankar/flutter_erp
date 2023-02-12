import 'package:flutter_erp/app/data/models/customer.dart';
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

class Subscription extends Resource {
  @override
  int? id;
  int? customerId;
  int? packageId;
  int? paymentId;
  int? branchId;
  int? classId;
  int? modeId;
  DateTime? subscribedAt;
  DateTime? expiringAt;
  Customer? customer;
  Package? package;
  Payment? payment;

  Subscription({
    this.id,
    this.customerId,
    this.packageId,
    this.paymentId,
    this.branchId,
    this.classId,
    this.subscribedAt,
    this.expiringAt,
    this.customer,
    this.modeId,
    this.package,
    this.payment,
  });

  @override
  Subscription fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'],
      customerId: map['customer_id'],
      packageId: map['package_id'],
      paymentId: map['payment_id'],
      branchId: map['branch_id'],
      classId: map['class_id'],
      modeId: map['mode_id'],
      expiringAt:
          map['expiringAt'] != null ? DateTime.parse(map['expiringAt']) : null,
      subscribedAt: map['subscribedAt'] != null
          ? DateTime.parse(map['subscribedAt'])
          : null,
      customer:
          map['customer'] != null ? Customer().fromMap(map['customer']) : null,
      package:
          map['package'] != null ? Package().fromMap(map['package']) : null,
      payment:
          map['payment'] != null ? Payment().fromMap(map['payment']) : null,
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
          data: package?.classDetails?.title,
        ),
        Cell(
          data: package?.name,
        ),
        Cell(
          data: payment?.mode?.title,
        ),
        Cell(
          data: getExpiringDate(),
        ),
        Cell(
          data: getSubscribedDate(),
        ),
      ],
    );
  }

  String getExpiringDate() {
    return expiringAt == null ? "-" : DateFormat('d MMM y').format(expiringAt!);
  }

  String getSubscribedDate() {
    return subscribedAt == null
        ? "-"
        : DateFormat('d MMM y').format(subscribedAt!);
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
      "package_id": packageId,
      "branch_id": branchId,
      "payment_id": paymentId,
      "mode_id": modeId,
      "expiringAt":
          expiringAt == null ? null : DateFormat('d MMM y').format(expiringAt!),
      if (subscribedAt != null)
        "subscribedAt": DateFormat('d MMM y').format(subscribedAt!)
    };
  }

  @override
  String toString() {
    return 'Subscription{id: $id, customerId: $customerId, packageId: $packageId, paymentId: $paymentId, classId: $classId, modeId: $modeId, subscribedAt: $subscribedAt, expiringAt: $expiringAt, customer: $customer, package: $package}';
  }
}
