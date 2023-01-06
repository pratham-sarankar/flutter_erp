import 'package:flutter_erp/app/data/utils/resource_manager/row/cell.dart';

class ResourceRow {
  final List<Cell> cells;

  ResourceRow({required this.cells});

  static ResourceRow get empty => ResourceRow(cells: []);
}
