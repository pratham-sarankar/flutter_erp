import 'package:flutter_erp/app/data/models/module.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:resource_manager/resource_manager.dart';

class ModuleRepository extends Repository<Module> {
  ModuleRepository() : super(path: '/module');

  List<Module> modules = [];

  Future init() async {
    modules = await fetch();
  }

  @override
  Future<Request> authenticator(Request request) async {
    return request;
  }

  @override
  Module get empty => Module();
}
