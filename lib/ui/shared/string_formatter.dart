/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:intl/intl.dart';

/// Class provides static methods to format certain strings.
class StringFormatter {
  /// Return a formatted date time string in the common format hh:mm:ss.
  static String getFormattedClockTimeString(DateTime clockString) {
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(clockString.toLocal());
  }

  /// Return a formatted string without the clock time.
  static String getFormattedShortDateString(DateTime dateString) {
    var formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(dateString);
  }

  /// Retrun a formated strting as yyyy-MM-dd
  static String getFormattedShortDateStringWithLines(DateTime datetTime) {
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(datetTime);
  }

  /// Return a formatted string of a [Duration].
  static String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  /// Return the string type of an enum.
  static String getEnumString(var enumString) {
    return enumString.toString().split('.')[1];
  }
}
