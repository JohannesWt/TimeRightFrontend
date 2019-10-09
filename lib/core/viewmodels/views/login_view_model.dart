import 'package:flutter/cupertino.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/services/authentication_service.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  LoginViewModel(
      {@required AuthenticationService authenticationService,
      @required EmployeeDetailsService employeeDetailsService})
      : _authenticationService = authenticationService,
        _employeeDetailsService = employeeDetailsService;

  AuthenticationService _authenticationService;

  EmployeeDetailsService _employeeDetailsService;

  Future<Employee> login(String employeeID) async {
    setBusy(true);
    var fetchedEmployee = await _authenticationService.login(employeeID);
    if (fetchedEmployee != null) {
      await getEmployeeDetails(fetchedEmployee.employeeID);
    }
    setBusy(false);
    return fetchedEmployee;
  }

  Future getEmployeeDetails(String employeeID) async {
    await _employeeDetailsService.fetchEmployeeDetails(employeeID);
  }
}
