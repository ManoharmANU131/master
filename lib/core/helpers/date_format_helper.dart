import 'package:intl/intl.dart';

class DateHelper {
  static final _dateFormatter = DateFormat('dd/MM/yyyy');
  static final _dateTimeFormatter = DateFormat('dd/MM/yyyy hh:mm a');

  static int? toMillis(DateTime? date) {
    return date?.millisecondsSinceEpoch;
  }

  static DateTime? fromMillis(dynamic value) {
    if (value == null) return null;

    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);

    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) {
        return DateTime.fromMillisecondsSinceEpoch(parsed);
      }
    }

    return null;
  }

  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return _dateFormatter.format(date);
  }

  static String formatDateTime(DateTime? date) {
    if (date == null) return '';
    return _dateTimeFormatter.format(date);
  }

  static int nowMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}