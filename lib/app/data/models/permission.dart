import 'package:flutter_erp/app/data/models/module.dart';
import 'package:resource_manager/resource_manager.dart';

class Permission extends Resource {
  final Module? module;
  final int? groupId;
  final int? moduleId;
  bool canAdd;
  bool canEdit;
  bool canDelete;
  bool canView;

  Permission({
    this.module,
    this.groupId,
    this.moduleId,
    this.canAdd = false,
    this.canEdit = false,
    this.canDelete = false,
    this.canView = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'module': module?.toMap(),
      'canAdd': canAdd,
      'canEdit': canEdit,
      'canDelete': canDelete,
      'canView': canView,
      'group_id':groupId,
      "module_id":moduleId,
    };
  }

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      groupId: map['group_id'],
      moduleId: map['module_id'],
      module: Module().fromMap(map['module']),
      canAdd: map['canAdd'],
      canEdit: map['canEdit'],
      canDelete: map['canDelete'],
      canView: map['canView'],
    );
  }

  @override
  String toString() {
    return 'Permission{module: $module, canAdd: $canAdd, canEdit: $canEdit, canDelete: $canDelete, canView: $canView}';
  }

  @override
  fromMap(Map<String, dynamic> map) {
    return Permission(
      module: Module().fromMap(map['module']),
      canAdd: map['canAdd'],
      canEdit: map['canEdit'],
      canDelete: map['canDelete'],
      canView: map['canView'],
    );
  }

  @override
  List<Field> getFields() {
    return [];
  }

  @override
  int? get id => moduleId;

  @override
  bool get isEmpty => module?.id == null;

  @override
  String? get name => module!.name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Permission &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId &&
          moduleId == other.moduleId;

  @override
  int get hashCode => groupId.hashCode ^ moduleId.hashCode ^ canView.hashCode;
}
