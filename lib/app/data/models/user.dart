import 'package:flutter_erp/app/data/models/employee.dart';
import 'package:flutter_erp/app/data/models/permission_group.dart';
import 'package:flutter_erp/app/data/repositories/employee_repository.dart';
import 'package:flutter_erp/app/data/repositories/permission_group_repository.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/abstracts/resource.dart';
import 'package:resource_manager/widgets/resource_table_view.dart';

class User extends Resource<User> {
  @override
  final int? id;
  @override
  String? get name => username;

  String? username;
  int? employeeId;
  int? groupId;
  Employee? employee;
  PermissionGroup? permissionGroup;
  String? password;

  User({
    this.id,
    this.username,
    this.employeeId,
    this.groupId,
    this.employee,
    this.password,
    this.permissionGroup,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'employee_id': employeeId,
      'group_id': groupId,
      'employee': employee?.toMap(),
      'permission_group': permissionGroup?.toMap(),
      if (password != null) 'password': password!,
    };
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

  @override
  User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      employeeId: map['employee_id'],
      groupId: map['group_id'],
      employee:
          map['employee'] == null ? null : Employee().fromMap(map['employee']),
      password: map['password'],
      permissionGroup: map['permission_group'] == null
          ? null
          : PermissionGroup().fromMap(map['permission_group']),
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field("username", FieldType.name, label: "Username", isRequired: true),
      Field("password", FieldType.password,
          label: "Password", isRequired: id == null),
      Field(
        "group_id",
        FieldType.dropdown,
        isRequired: true,
        label: "Permission Group",
        foreignRepository: Get.find<PermissionGroupRepository>(),
      ),
      Field(
        "employee_id",
        FieldType.foreign,
        isRequired: true,
        foreignRepository: Get.find<EmployeeRepository>(),
      ),
    ];
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(columns: []);
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    return ResourceRow(cells: []);
  }

  @override
  bool get isEmpty => id == null;
}
