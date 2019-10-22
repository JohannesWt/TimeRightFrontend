import 'package:intl/intl.dart';

class StringFormatter {
  static String getFormattedClockTimeString(DateTime clockString) {
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(clockString.toLocal());
  }

  static String getFormattedShortDateString(DateTime dateString) {
    var formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(dateString);
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
