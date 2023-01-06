class ResourceColumn {
  final List<String> columns;
  ResourceColumn({required this.columns});

  static ResourceColumn get empty => ResourceColumn(columns: []);
}
