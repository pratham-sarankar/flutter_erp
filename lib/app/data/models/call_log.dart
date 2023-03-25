import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:resource_manager/resource_manager.dart';

class CallLog extends Resource {
  @override
  final int? id;
  final String? customerPhoneNumber;
  final String? branchPhoneNumber;
  final String? type;
  final String? status;
  final String? duration;
  final String? recordingUrl;
  final DateTime? date;
  final String? time;
  final int? branchId;
  final int? customerId;
  final Customer? customer;

  CallLog({
    this.id,
    this.customerPhoneNumber,
    this.branchPhoneNumber,
    this.type,
    this.time,
    this.date,
    this.status,
    this.duration,
    this.recordingUrl,
    this.branchId,
    this.customerId,
    this.customer,
  });

  @override
  fromMap(Map<String, dynamic> map) {
    return CallLog(
      id: map['id'],
      status: map['status'],
      date: map['date'] == null ? null : DateTime.parse(map['date']),
      type: map['type'],
      duration: map['duration'],
      recordingUrl: map['recordingUrl'],
      time: map['time'],
      branchId: map['branch_id'],
      branchPhoneNumber: map['branch_phone_number'],
      customerId: map['customer_id'],
      customerPhoneNumber: map['customer_phone_number'],
      customer:
          map['customer'] == null ? null : Customer().fromMap(map['customer']),
    );
  }

  @override
  List<Field> getFields() {
    throw UnimplementedError();
  }

  bool get isFromExistingCustomer => customerId != null;

  @override
  bool get isEmpty => id == null;

  @override
  String get name => customer?.name ?? number;

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  IconData get icon {
    return type == "OUTBOUND"
        ? CupertinoIcons.phone_fill_arrow_up_right
        : CupertinoIcons.phone_fill_arrow_down_left;
  }

  Color get statusColor {
    return status == "Missed" ? Colors.red.shade700 : Colors.green.shade700;
  }

  String get number {
    return customerPhoneNumber ?? "-";
  }

  String get description {
    var type = this.type == "INBOUND" ? "Inbound" : "Outbound";
    return "$type call, ${_formatDuration(duration ?? "00:00")}";
  }

  String _formatDuration(String duration) {
    var list = duration.split(":");
    if (list[0].padLeft(2, "0") == "00") {
      return "${list[1]} secs";
    }
    return "${list[0]} min ${list[1]} secs";
  }

  String get formattedTime {
    if (time == null) return "-";
    var list = time?.split(":");
    int hour = int.parse(list![0]);
    int minute = int.parse(list[1]);
    var prefix = hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $prefix";
  }
}
