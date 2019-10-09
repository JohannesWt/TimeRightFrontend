import 'package:intl/intl.dart';

class StringFormatter {
  static String getFormattedClockTimeString(DateTime clockString) {
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(clockString);
  }

  static String getFormattedShortDateString(DateTime dateString) {
    var formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(dateString);
  }
}
