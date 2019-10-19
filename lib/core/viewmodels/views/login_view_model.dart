import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/services/authentication_service.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  LoginViewModel(
      {@required AuthenticationService authenticationService,
      @required EmployeeDetailsService employeeDetailsService,
      @required TimeStampService timeStampService})
      : _authenticationService = authenticationService,
        _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService;

  final AuthenticationService _authenticationService;

  final EmployeeDetailsService _employeeDetailsService;

  int get stampFails => _employeeDetailsService.employeeDetails.stampFailsSum;

  final TimeStampService _timeStampService;

  final TextEditingController _employeeIDController = TextEditingController();

  TextEditingController get employeeIDController => _employeeIDController;

  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get passwordController => _passwordController;

  Future<Employee> login() async {
    setBusy(true);
    var fetchedEmployee = await _authenticationService.login(
        _employeeIDController.text, _passwordController.text);
    if (fetchedEmployee != null) {
      await getEmployeeDetails(fetchedEmployee.employeeID);
    }
    setBusy(false);
    return fetchedEmployee;
  }

  Future getEmployeeDetails(int employeeID) async {
    await _employeeDetailsService.fetchEmployeeDetails(employeeID);
    // TODO: Current date as parameter
    await _timeStampService.fetchTimeStampDaysForMonth(
        employeeID, DateTime.now());
  }
}
