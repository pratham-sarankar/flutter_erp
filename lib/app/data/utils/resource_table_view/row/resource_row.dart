import 'package:flutter_erp/app/data/utils/resource_table_view/row/cell.dart';

class ResourceRow {
  final List<Cell> cells;

  ResourceRow({required this.cells});

  static ResourceRow get empty => ResourceRow(cells: []);
}
