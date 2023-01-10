import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

class Payment extends Resource {
  @override
  final int? id;
  int? customerId;
  int? amount;
  String? description;

  Payment({this.id, this.customerId, this.description, this.amount});

  @override
  Payment fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      amount: map['amount'],
      customerId: map['customer_id'],
      description: map['description'],
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
    return ResourceColumn(columns: ["Amount", "Description", "Actions"]);
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    return ResourceRow(cells: [
      Cell(data: "₹ $amount" ?? "-"),
      Cell(data: description ?? "-"),
      Cell(children: [
        Cell(
          data: "Edit",
          icon: Icons.edit,
          onPressed: () {
            controller.updateRow(this);
          },
          isAction: true,
        ),
        Cell(
          data: "Delete",
          icon: Icons.delete,
          onPressed: () {
            controller.destroyRow(this);
          },
          isAction: true,
        ),
      ])
    ]);
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
    };
  }
}
