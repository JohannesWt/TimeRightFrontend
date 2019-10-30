/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:time_right/core/services/authentication_service.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/views/profile_view.dart';

/// Model which handles the business logic for the [ProfileView]
class ProfileViewModel extends BaseModel {
  ProfileViewModel(
      {@required AuthenticationService authenticationService,
      @required TimeStampService timeStampService})
      : _authenticationService = authenticationService,
        _timeStampService = timeStampService;

  /// [AuthenticationService] to handle the log out process.
  final AuthenticationService _authenticationService;

  /// [TimeStampService] to reset the time stamp map
  final TimeStampService _timeStampService;

  /// Logs the current logged in user out.
  Future logOut() async {
    await _authenticationService.logOut().then((value) {
      _timeStampService.timeStampMap.clear();
    });
  }
}
