import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/api.dart';

class CalendarService {
  CalendarService({Api api}) : _api = api;

  final Api _api;

  List<TimeStampDay> _timeStampList;

  List<TimeStampDay> get timeStampList => _timeStampList;

  Future fetchTimeStampDaysForMonth(String employeeID, int month, int year) async {
    _timeStampList =
        await _api.fetchTimeStampDaysForMonth(employeeID, month, year);
  }
}