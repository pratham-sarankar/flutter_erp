import 'package:flutter_erp/app/data/models/Users/user.dart';

class UserCredential {
  final User user;
  final String? password;
  final String? token;

  UserCredential({required this.user, this.password, this.token});

  @override
  String toString() {
    return 'UserCredential{user: $user, password: $password, token: $token}';
  }

  Map<String, dynamic> toMap() {
    return {
      ...user.toMap(),
      'password': password,
      'token': token,
    };
  }

  factory UserCredential.fromMap(Map<String, dynamic> map) {
    return UserCredential(
      user: User.fromMap(map['user']),
      password: map['password'] as String,
      token: map['token'] as String,
    );
  }
}
