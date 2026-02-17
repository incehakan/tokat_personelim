import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate {
    return DateFormat.yMMMd('tr').format(this).toString();
  }

  String get formattedTime {
    return DateFormat.Hm('tr').format(this).toString();
  }
}
