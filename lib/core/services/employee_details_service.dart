import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/api.dart';

class EmployeeDetailsService {
  EmployeeDetailsService({Api api}) : _api = api;

  final Api _api;

  EmployeeDetails _employeeDetails;

  EmployeeDetails get employeeDetails => _employeeDetails;

  Future fetchEmployeeDetails(String employeeID) async {
    _employeeDetails = await _api.fetchEmployeeDetails(employeeID);
  }

  TimeStampDay fetchTimeStampsForDay(DateTime compDate) {
    // TODO: Compare to today's date
    TimeStampDay timeStampDay = _employeeDetails.timeStampDetails.firstWhere(
            (timeStampDay) => timeStampDay.date.day == 28);
    timeStampDay.timeStampEvents.sort((a, b) =>
        b.dateTime.compareTo(a.dateTime));
    return timeStampDay;
  }

  List<TimeStampDay> fetchTimeStampsDayList() {
    return _employeeDetails.timeStampDetails;
  }
}
