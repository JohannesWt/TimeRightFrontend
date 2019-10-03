import 'package:intl/intl.dart';

class StringFormatter {
  static String getFormattedClockTime(String clockString) {
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(DateTime.parse(clockString));
  }

  static String getFormattedShortDate(String dateString) {
    var formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(DateTime.parse(dateString));
  }
}
