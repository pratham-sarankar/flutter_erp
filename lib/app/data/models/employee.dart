import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:intl/intl.dart';

class Employee {
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dob': dob == null ? null : DateFormat("yyyy-M-dd").format(dob!),
      'photoUrl': photoUrl,
      'designation_id': designationId
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      dob: map['dob'] == null ? null : DateTime.parse(map['dob']),
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
}
