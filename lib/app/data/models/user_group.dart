class UserGroup {
  int? id;
  String? name;
  int? usersCount;

  UserGroup({
    this.id,
    this.name,
    this.usersCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'users_count': usersCount,
    };
  }

  factory UserGroup.fromMap(Map<String, dynamic> map) {
    return UserGroup(
      id: map['id'] as int,
      name: map['name'] as String,
      usersCount: map['users_count'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'UserGroup{id: $id, name: $name, employeesCount: $usersCount}';
  }

  String getName() {
    return name ?? "-";
  }

  int getUsersCount() {
    return usersCount ?? 0;
  }

  bool get hasEmployees => (usersCount ?? 0) > 0;
}
