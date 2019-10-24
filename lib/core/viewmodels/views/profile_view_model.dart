/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:time_right/core/services/authentication_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/views/profile_view.dart';

/// Model which handles the business logic for the [ProfileView]
class ProfileViewModel extends BaseModel {
  ProfileViewModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  /// [AuthenticationService] to handle the log out process.
  final AuthenticationService _authenticationService;

  /// Logs the current logged in user out.
  void logOut() {
    _authenticationService.logOut();
  }
}