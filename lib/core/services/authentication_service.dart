/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'dart:async';

import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/services/api.dart';

/// Service depends on [Api] and handles the login process.
class AuthenticationService {
  AuthenticationService({Api api}) : _api = api;

  final Api _api;

  /// Hold the login Employee data to access it from all over the app.
  StreamController<Employee> _employeeController = StreamController<Employee>();

  /// Get the Employee data from [_employeeController].
  Stream<Employee> get employee => _employeeController.stream;

  /// Uses api method fetchEmployee to get the login Employee information for
  /// an [employeeID] and the suitable [password].
  ///
  /// Return fetched employee from [_api.fetchEmployee(employeeID, password)].
  Future<Employee> login(String employeeID, String password) async {
    var fetchedEmployee = await _api.fetchEmployee(employeeID, password);
    if (fetchedEmployee != null) {
      /// Add [fetchedUser] to [_employeeController] after successful login.
      _employeeController.add(fetchedEmployee);
    }
    return fetchedEmployee;
  }

  /// Execute logout-method of [_api].
  Future logOut() async {
    await _api.logOut();
  }
}
