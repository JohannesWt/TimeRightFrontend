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

  /// Shows if the [_employeeDetails] are already loaded.
  bool _employeeDetailsLoaded = false;

  /// Set [_employeeDetailsLoaded]
  set employeeDetailsLoaded(bool value) {
    _employeeDetailsLoaded = value;
  }

  /// Return [_employeeDetailsLoaded]
  bool get loadedEmployeeDetails => _employeeDetailsLoaded;

  /// Set [_employeeDetails] to the response of the [_api]-service.
  Future fetchEmployeeDetails() async {
    if (!_employeeDetailsLoaded) {
      _employeeDetails = await _api.fetchEmployeeDetails();
      _employeeDetailsLoaded = true;
    }
  }

  /// [EmployeeProfile] of the current logged in employee.
  EmployeeProfile _employeeProfile;

  /// Return [_employeeProfile] of the current logged in employee.
  EmployeeProfile get employeeProfile => _employeeProfile;

  /// Shows if the [_employeeProfile] is already loaded.
  bool _employeeProfileLoaded = false;

  /// Set [_employeeProfileLoaded] to a new boolean
  set employeeProfileLoaded(bool value) {
    _employeeProfileLoaded = value;
  }

  /// Set [_employeeProfile] to the response of the [_api]-service.
  Future fetchEmployeeProfile() async {
    if (!_employeeProfileLoaded) {
      _employeeProfile = await _api.fetchEmployeeProfile();
      _employeeProfileLoaded = true;
    }
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
