import 'package:flutter_erp/app/data/utils/resource_manager/columns/table_column.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/row/resource_row.dart';
import 'package:flutter_erp/app/data/utils/resource_manager/table_view.dart';

abstract class Resource {
  ResourceRow getResourceRow(TableController controller);
  ResourceColumn getResourceColumn();
}
