import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/api.dart';

class EmployeeDetailsService {
  EmployeeDetailsService({Api api}) : _api = api;

  final Api _api;

  EmployeeDetails _employeeDetails;

  EmployeeDetails get employeeDetails => _employeeDetails;

  Future getEmployeeDetails(String employeeID) async {
    _employeeDetails = await _api.getEmployeeDetails(employeeID);
  }

  TimeStampDay getTimeStampsForDay(DateTime compDate) {
    // TODO: Compare to today's date
    TimeStampDay timeStampDay = _employeeDetails.timeStampDetails.firstWhere(
            (timeStampDay) => DateTime.parse(timeStampDay.date).day == 28);
    timeStampDay.timeStampEvents.sort((a, b) =>
        DateTime.parse(b.dateTime).compareTo(DateTime.parse(a.dateTime)));
    return timeStampDay;
  }

  List<TimeStampDay> getTimeStampsDayList() {
    return _employeeDetails.timeStampDetails;
  }
}
