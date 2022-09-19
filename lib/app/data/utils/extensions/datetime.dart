import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format(String format) {
    DateFormat dateFormat = DateFormat(format);
    String result = dateFormat.format(this);
    return result;
  }
}
