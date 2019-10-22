import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/services/api.dart';

class EmployeeDetailsService {
  EmployeeDetailsService({Api api}) : _api = api;

  final Api _api;

  EmployeeDetails _employeeDetails;

  EmployeeDetails get employeeDetails => _employeeDetails;

  Future fetchEmployeeDetails(int employeeID) async {
    _employeeDetails = await _api.fetchEmployeeDetails(employeeID);
  }

  Duration getContractWorkHours() {
    double workHoursDouble = _employeeDetails.contractDetails.workHours / 5;
    List<String> splitString = workHoursDouble.toString().split(".");
    return Duration(
        hours: int.parse(splitString[0]), minutes: int.parse(splitString[1]));
  }
}
