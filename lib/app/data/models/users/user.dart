import 'package:flutter_erp/app/data/models/employee.dart';

class User {
  final int? id;
  String? username;
  int? employeeId;
  int? groupId;
  Employee? employee;

  User({this.id, this.username, this.employeeId, this.groupId, this.employee});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'employee_id': employeeId,
      'group_id': groupId,
      'employee': employee?.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'] as String,
      employeeId: map['employee_id'] as int,
      groupId: map['group_id'] as int,
      employee:
          map['employee'] != null ? Employee.fromMap(map['employee']) : null,
    );
  }

  String getPhotoUrl() {
    return employee?.getPhotoUrl() ??
        "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg";
  }

  String getName() {
    return employee?.getName() ?? "-";
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, employeeId: $employeeId, groupId: $groupId, employee: $employee}';
  }
}
