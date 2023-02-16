import 'package:resource_manager/data/abstracts/resource.dart';

class Module extends Resource {
  @override
  final int? id;

  @override
  final String? name;
  final bool canAdd;
  final bool canEdit;
  final bool canDelete;
  final bool canView;

  Module({
    this.id,
    this.name,
    this.canAdd = false,
    this.canEdit = false,
    this.canDelete = false,
    this.canView = false,
  });

  @override
  fromMap(Map<String, dynamic> map) {
    return Module(
      id: map['id'],
      name: map['name'],
      canAdd: map['canAdd'] ?? false,
      canEdit: map['canEdit'] ?? false,
      canDelete: map['canDelete'] ?? false,
      canView: map['canView'] ?? false,
    );
  }

  @override
  List<Field> getFields() {
    throw UnimplementedError();
  }

  @override
  bool get isEmpty => id == null;

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "canAdd": canAdd,
      "canEdit": canEdit,
      "canDelete": canDelete,
      "canView": canView,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Module && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
