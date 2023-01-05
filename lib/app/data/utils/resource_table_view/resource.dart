import 'package:flutter_erp/app/data/utils/resource_table_view/columns/table_column.dart';
import 'package:flutter_erp/app/data/utils/resource_table_view/row/resource_row.dart';
import 'package:flutter_erp/app/data/utils/resource_table_view/table_view.dart';

abstract class Resource {
  ResourceRow getResourceRow(TableController controller);
  ResourceColumn getResourceColumn();
}
