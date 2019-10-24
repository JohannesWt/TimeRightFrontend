/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

/// Class provides static methods to calculate specified dates.
class DateCalculator {

  /// Check if [firstDate] is on the same day as [secondDate]
  /// Return true/false;
  static bool isOnSameDay(DateTime firstDate, DateTime secondDate) {
    if (firstDate.year == secondDate.year &&
        firstDate.month == secondDate.month && firstDate.day == secondDate.day) {
      return true;
    }
    return false;
  }

  /// Return new datetime from [compDate] without clock time.
  static DateTime shortFormDateTime(DateTime compDate) {
    return DateTime(compDate.year, compDate.month, compDate.day);
  }
}