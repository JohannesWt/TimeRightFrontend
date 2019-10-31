/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/employee_profile/employee_profile.dart';
import 'package:time_right/core/services/api.dart';

/// Service depends on [Api] and holds [EmployeeDetails]-data of current logged
/// in employee.
class EmployeeDetailsService {
  EmployeeDetailsService({Api api}) : _api = api;

  final Api _api;

  /// [EmployeeDetails] of the current logged in employee.
  EmployeeDetails _employeeDetails;

  /// Return [_employeeDetails] of the current logged in employee.
  EmployeeDetails get employeeDetails => _employeeDetails;

  /// Set [_employeeDetails] to the response of the [_api]-service.
  Future fetchEmployeeDetails() async {
    _employeeDetails = await _api.fetchEmployeeDetails();
  }

  /// [EmployeeProfile] of the current logged in employee.
  EmployeeProfile _employeeProfile;

  /// Return [_employeeProfile] of the current logged in employee.
  EmployeeProfile get employeeProfile => _employeeProfile;

  /// Set [_employeeProfile] to the response of the [_api]-service.
  Future fetchEmployeeProfile() async {
    _employeeProfile = await _api.fetchEmployeeProfile();
  }

  /// Return daily [workHours] of the current logged in employee. (This
  /// information is specified in the [_employeeDetails].)
  Duration getContractWorkHours() {
    double workHoursDouble = _employeeDetails.contractDetails.workHours / 5;
    List<String> splitString = workHoursDouble.toString().split(".");
    return Duration(
        hours: int.parse(splitString[0]), minutes: int.parse(splitString[1]));
  }
}
