import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class Payment extends Resource {
  @override
  final int? id;
  int? customerId;
  Customer? customer;
  int? amount;
  int? branchId;
  String? description;

  Payment({
    this.id,
    this.customerId,
    this.description,
    this.amount,
    this.branchId,
    this.customer,
  });

  @override
  Payment fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      amount: int.parse(map['amount'].toString()),
      customerId: map['customer_id'],
      description: map['description'],
      branchId: map['branch_id'],
      customer:
          map['customer'] == null ? null : Customer().fromMap(map['customer']),
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field(
        "customer_id",
        FieldType.foreign,
        foreignRepository: Get.find<CustomerRepository>(),
        isRequired: true,
        label: "Customer",
      ),
      Field("amount", FieldType.number, label: "Amount"),
      Field("description", FieldType.text, label: "Description"),
    ];
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(columns: [
      "Amount",
      "Description",
      "Customer",
      if (Get.find<AuthService>().canEdit("Payments") ||
          Get.find<AuthService>().canDelete("Payments"))
        "Actions",
    ]);
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    return ResourceRow(
      cells: [
        Cell(data: "₹ $amount" ?? "-"),
        Cell(data: description ?? "-"),
        Cell(data: customer?.username ?? "-"),
        if (Get.find<AuthService>().canEdit("Payments") ||
            Get.find<AuthService>().canDelete("Payments"))
          Cell(children: [
            if (Get.find<AuthService>().canEdit("Payments"))
              Cell(
                data: "Edit",
                icon: Icons.edit,
                onPressed: () {
                  controller.updateRow(this);
                },
                isAction: true,
              ),
            if (Get.find<AuthService>().canDelete("Payments"))
              Cell(
                data: "Delete",
                icon: Icons.delete,
                onPressed: () {
                  controller.destroyRow(this);
                },
                isAction: true,
              ),
          ])
      ],
    );
  }

  @override
  bool get isEmpty => id == null;

  @override
  String? get name => description;

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "customer_id": customerId,
      "description": description,
      "amount": amount,
      'branch_id': branchId,
    };
  }
}
