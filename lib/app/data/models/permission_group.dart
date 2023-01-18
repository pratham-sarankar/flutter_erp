import 'package:flutter_erp/app/data/models/permission.dart';
import 'package:resource_manager/resource_manager.dart';

import 'module.dart';

class PermissionGroup extends Resource<PermissionGroup> {
  @override
  int? id;

  @override
  String? name;
  int? usersCount;
  List<Permission> permissions;

  PermissionGroup({
    this.id,
    this.name,
    this.usersCount,
    this.permissions = const [],
  });

  bool get isAdminGroup => name == "Admin";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'users_count': usersCount,
      'permissions': permissions.map((e) => e.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'PermissionGroup{id: $id, name: $name, usersCount: $usersCount, permissions: $permissions}';
  }

  List<Module?> get modules => permissions.map((e) => e.module).toList();

  String getName() {
    return name ?? "-";
  }

  int getUsersCount() {
    return usersCount ?? 0;
  }

  bool get hasEmployees => (usersCount ?? 0) > 0;

  @override
  fromMap(Map<String, dynamic> map) {
    return PermissionGroup(
      id: map['id'],
      name: map['name'],
      usersCount: map['users_count'] ?? 0,
      permissions: List.from(map['permissions'])
          .map((map) => Permission.fromMap(map))
          .toList(),
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field(
        "name",
        FieldType.name,
        isSearchable: true,
        label: "Name",
        isRequired: true,
      ),
    ];
  }

  @override
  bool get isEmpty => id == null;
}
