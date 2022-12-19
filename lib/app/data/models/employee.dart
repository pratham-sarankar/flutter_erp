import 'package:intl/intl.dart';

class Employee {
  final int? id;
  String? firstName;
  String? lastName;
  String? username;
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
    this.username,
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
      'username': username,
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
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      dob: map['dob'] == null ? null : DateTime.parse(map['dob']),
      designationId: map['designation_id'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phoneNumber: $phoneNumber, dob: $dob, photoUrl: $photoUrl}';
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
    return "http://localhost:3000/employee/images/$photoUrl";
  }

  String getName() {
    if (firstName == null && lastName == null) {
      return username ?? '-';
    }
    return "$firstName $lastName";
  }

  String getPhoneNumber() {
    return phoneNumber ?? "-";
  }

  String getDateOfBirth() {
    return dob == null ? "-" : DateFormat('d MMM y').format(dob!);
  }
}
