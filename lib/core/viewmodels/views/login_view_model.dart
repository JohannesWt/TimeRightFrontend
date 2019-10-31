/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/services/authentication_service.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/views/login_view.dart';

/// Model which handles the business logic of the [LoginView].
class LoginViewModel extends BaseModel {
  LoginViewModel(
      {@required AuthenticationService authenticationService,
      @required EmployeeDetailsService employeeDetailsService,
      @required TimeStampService timeStampService})
      : _authenticationService = authenticationService,
        _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService;

  /// [AuthenticationService] to handle the login process
  final AuthenticationService _authenticationService;

  /// [EmployeeDetailsService] to fetch the data for the current logged in employee
  final EmployeeDetailsService _employeeDetailsService;

  /// Return [EmployeeDetails]
  EmployeeDetails get employeeDetails =>
      _employeeDetailsService.employeeDetails;

  /// [TimeStampService] to fetch [_timeStampService.timeStampMap].
  final TimeStampService _timeStampService;

  /// Controller to get the employeeID from the login form.
  final TextEditingController _employeeIDController = TextEditingController();

  /// Return [_employeeIDController].
  TextEditingController get employeeIDController => _employeeIDController;

  /// Controller to get the password from the login form.
  final TextEditingController _passwordController = TextEditingController();

  /// Return [_passwordController].
  TextEditingController get passwordController => _passwordController;

  /// Handles login process.
  ///
  /// Set this model to busy, to display a circular loading processor on the view.
  /// Fetch an employee from [_authenticationService] with the login form parameters.
  /// If the fetched employee exists (!=null) call [getEmployeeDetails].
  ///
  /// After the login process, set busy of this model to false to continue the
  /// process of the ui.
  ///
  /// Return the fetched employee.
  Future<Employee> login() async {
    setBusy(true);
    var fetchedEmployee = await _authenticationService.login(
        _employeeIDController.text, _passwordController.text);
    setBusy(false);
    return fetchedEmployee;
  }

  /// Fetch details from employee with [employeeID].
  Future getEmployeeDetails() async {
    setBusy(true);
    await _employeeDetailsService.fetchEmployeeDetails();
    setBusy(false);
  }

  /// Fetch time stamp map from [employeeID] from the current month.
  Future getTimeStampsForMonth(DateTime dateTime) async {
    setBusy(true);
    await _timeStampService.fetchTimeStampDaysForMonth(DateTime.now());
    setBusy(false);
  }

  /// Fetch executive details like applications if current logged in employee
  /// as an executive.
  Future getExecutiveDetails() async {
    setBusy(true);
    await _timeStampService.fetchApplicationsForMonth(DateTime.now());
    setBusy(false);
  }
}
