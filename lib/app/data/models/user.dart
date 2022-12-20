class User {
  final String username;
  final int employeeId;

  User({required this.username, required this.employeeId});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'employeeId': employeeId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      employeeId: map['employeeId'] as int,
    );
  }
}
