class Branch {
  final int? id;
  String? name;
  String? address;
  String? phoneNumber;
  final int employeesCount;
  final int customersCount;
  final int classesCount;
  final int coursesCount;

  Branch({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.employeesCount = 0,
    this.customersCount = 0,
    this.classesCount = 0,
    this.coursesCount = 0,
  });

  @override
  String toString() {
    return 'Branch{id: $id, name: $name, address: $address, phoneNumber: $phoneNumber, employeesCount: $employeesCount, customersCount: $customersCount, classesCount: $classesCount, coursesCount: $coursesCount}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'employees_count': employeesCount,
      'customers_count': customersCount,
      'classes_count': classesCount,
      'courses_count': coursesCount,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      employeesCount: map['employees_count'] ?? 0,
      customersCount: map['customers_count'] ?? 0,
      classesCount: map['classes_count'] ?? 0,
      coursesCount: map['courses_count'] ?? 0,
    );
  }
}
