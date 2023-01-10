import 'package:resource_manager/resource_manager.dart';

class PermissionGroup extends Resource<PermissionGroup> {
  @override
  int? id;

  @override
  String? name;
  int? usersCount;

  PermissionGroup({
    this.id,
    this.name,
    this.usersCount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'users_count': usersCount,
    };
  }

  @override
  String toString() {
    return 'PermissionGroup{id: $id, name: $name, employeesCount: $usersCount}';
  }

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
