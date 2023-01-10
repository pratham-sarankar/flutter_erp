import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/repositories/designation_repository.dart';
import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resource_manager/resource_manager.dart';

class Employee extends Resource {
  @override
  final int? id;

  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? dob;
  String? photoUrl;
  int? designationId;

  Employee({
    this.id,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.email,
    this.phoneNumber,
    this.dob,
    this.designationId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dob': dob == null ? null : getDateOfBirth(),
      'photoUrl': photoUrl,
      'designation_id': designationId,
    };
  }

  @override
  Employee fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      dob: map['dob'] == null ? null : setDateOfBirth(map['dob']),
      designationId: map['designation_id'],
    );
  }

  @override
  String toString() {
    return 'Employee{id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, dob: $dob, photoUrl: $photoUrl, designationId: $designationId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Employee && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  String getEmail() => email ?? "-";

  String? getPhotoUrl() {
    if (photoUrl == null) return null;
    return FileRepository.instance.getUrl(photoUrl!);
  }

  String getName() {
    return "$firstName $lastName";
  }

  String getPhoneNumber() {
    return phoneNumber ?? "-";
  }

  String getDateOfBirth() {
    return dob == null ? "-" : DateFormat('d MMM y').format(dob!);
  }

  DateTime setDateOfBirth(String data) {
    var date = DateTime.tryParse(data);
    date ??= DateFormat('d MMM y').parse(data);
    return date;
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(
        columns: ["Name", "Email", "Phone number", "Date of birth", "Actions"]);
  }

  @override
  ResourceRow getResourceRow(TableController controller) {
    return ResourceRow(
      cells: [
        Cell(
          data: getPhotoUrl(),
          children: [Cell(data: "${firstName ?? ""} ${lastName ?? ""}")],
        ),
        Cell(data: getEmail()),
        Cell(data: getPhoneNumber()),
        Cell(data: getDateOfBirth()),
        Cell(children: [
          Cell(
            data: "Edit",
            icon: Icons.edit,
            isAction: true,
            onPressed: () {
              controller.updateRow(this);
            },
          ),
          Cell(
            data: "Delete",
            icon: Icons.delete,
            isAction: true,
            onPressed: () {
              controller.destroyRow(this);
            },
          ),
        ])
      ],
    );
  }

  @override
  Future<Uint8List> fileDownloader(String key) =>
      FileRepository.instance.imageDownloader(key);

  @override
  Future<String> fileUploader(Uint8List data) =>
      FileRepository.instance.imageUploader(data);

  @override
  bool get isEmpty => id == null;

  @override
  String get name => "${firstName ?? ""} ${lastName ?? ""}";

  @override
  List<Field> getFields() {
    return [
      Field("photoUrl", FieldType.image, label: "Profile Photo"),
      Field("firstName", FieldType.name, label: "First Name"),
      Field("lastName", FieldType.name, label: "Last Name"),
      Field("email", FieldType.email, label: "Email", isSearchable: true),
      Field(
        "phoneNumber",
        FieldType.phoneNumber,
        label: "Phone Number",
        isRequired: true,
        isSearchable: true,
      ),
      Field('designation_id', FieldType.dropdown,
          label: "Designation",
          foreignRepository: Get.find<DesignationRepository>()),
      Field(
        'dob',
        FieldType.date,
        label: "Date of birth",
        hint: "MM/DD/YYYY",
      ),
    ];
  }
}
