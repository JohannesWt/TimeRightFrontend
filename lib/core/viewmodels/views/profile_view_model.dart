/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:time_right/core/models/employee_profile/employee_profile.dart';
import 'package:time_right/core/services/authentication_service.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/core/viewmodels/widgets/work_time_clock_model.dart';
import 'package:time_right/ui/views/profile_view.dart';

/// Model which handles the business logic for the [ProfileView]
class ProfileViewModel extends BaseModel {
  ProfileViewModel(
      {@required AuthenticationService authenticationService,
      @required TimeStampService timeStampService,
      @required EmployeeDetailsService employeeDetailsService})
      : _authenticationService = authenticationService,
        _timeStampService = timeStampService,
        _employeeDetailsService = employeeDetailsService;

  /// [AuthenticationService] to handle the log out process.
  final AuthenticationService _authenticationService;

  /// [TimeStampService] to reset the time stamp map
  final TimeStampService _timeStampService;

  final EmployeeDetailsService _employeeDetailsService;

  /// Logs the current logged in user out.
  Future logOut() async {
    await _authenticationService.logOut().then((value) {
      print('rein');
      WorkTimeClockModel.workTimer.cancel();
      _timeStampService.timeStampMap.clear();
      _employeeDetailsService.employeeDetailsLoaded = false;
      _employeeDetailsService.employeeProfileLoaded = false;
    });
  }

  EmployeeProfile get employeeProfile =>
      _employeeDetailsService.employeeProfile;

  Future fetchEmployeeProfile() async {
    setBusy(true);
    await _employeeDetailsService.fetchEmployeeProfile();
    setBusy(false);
  }
}
