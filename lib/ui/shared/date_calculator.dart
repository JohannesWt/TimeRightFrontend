class DateCalculator {
  static bool isOnSameDay(DateTime firstDate, DateTime secondDate) {
    if (firstDate.year == secondDate.year &&
        firstDate.month == secondDate.month && firstDate.day == secondDate.day) {
      return true;
    }
    return false;
  }
}