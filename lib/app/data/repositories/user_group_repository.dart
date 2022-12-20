import 'package:flutter_erp/app/data/models/user.dart';
import 'package:flutter_erp/app/data/models/user_group.dart';
import 'package:flutter_erp/app/data/providers/user_group_provider.dart';

class UserGroupRepository {
  final UserGroupProvider _provider;

  UserGroupRepository._privateConstructor() : _provider = UserGroupProvider();

  static final instance = UserGroupRepository._privateConstructor();

  Future<UserGroup> insertOne(UserGroup group) async {
    return await _provider.insertOne(group: group);
  }

  Future<List<UserGroup>> fetchAll() async {
    return await _provider.fetchAll();
  }

  Future<List<User>> fetchOneWithUsers(int id) async {
    return await _provider.fetchOneWithUsers(id);
  }

  Future<UserGroup> updateOne(UserGroup group) async {
    return await _provider.updateOne(group);
  }

  Future<void> deleteOne(UserGroup group) async {
    return await _provider.deleteOne(group);
  }
}
