import 'package:flutter_erp/app/data/repositories/file_repository.dart';
import 'package:intl/intl.dart';

class Customer {
  final int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? photoUrl;
  String? email;
  String? phoneNumber;
  String? password;
  DateTime? dob;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.photoUrl,
    this.email,
    this.phoneNumber,
    this.password,
    this.dob,
  });

  @override
  bool operator ==(Object other) => (other is Customer) && id == other.id;

  @override
  int get hashCode => id.hashCode;

  bool get hasPhoto => photoUrl != null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'photoUrl': photoUrl,
      'email': email,
      'phoneNumber': phoneNumber,
      if (password != null) 'password': password,
      'dob': dob?.toIso8601String(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['username'],
      photoUrl: map['photoUrl'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      dob: map['dob'] == null ? null : DateTime.parse(map['dob']),
    );
  }

  String getName() {
    if (firstName == null && lastName == null) {
      return username ?? '-';
    }
    return "$firstName $lastName";
  }

  String? getPhotoUrl() {
    if (photoUrl == null) return null;
    return FileRepository.instance.getUrl(photoUrl!);
  }

  String getEmail() {
    return email ?? "-";
  }

  String getPhoneNumber() {
    return phoneNumber ?? "-";
  }

  String getDateOfBirth() {
    return dob == null ? "-" : DateFormat('d MMM y').format(dob!);
  }

  @override
  String toString() {
    return 'Customer{id: $id, firstName: $firstName, lastName: $lastName, username: $username, photoUrl: $photoUrl, email: $email, phoneNumber: $phoneNumber, dob: $dob}';
  }
}
