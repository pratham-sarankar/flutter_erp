import 'package:intl/intl.dart';

class Customer {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? photoUrl;
  final String? email;
  final String? phoneNumber;
  final DateTime? dob;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.photoUrl,
    this.email,
    this.phoneNumber,
    this.dob,
  });

  @override
  bool operator ==(Object other) => (other is Customer) && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'photoUrl': photoUrl,
      'email': email,
      'phoneNumber': phoneNumber,
      'dob': dob?.toIso8601String(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int,
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['username'],
      photoUrl: map['photoUrl'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      dob: map['dob'] == null ? null : DateTime.parse(map['dob']),
    );
  }

  String getName() {
    if (firstName == null && lastName == null) {
      return username ?? '-';
    }
    return "$firstName $lastName";
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
}
