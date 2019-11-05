/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

/// Model which handles the business logic of the [FlexDayViewModel].
class FlexDayViewModel extends BaseModel {
  FlexDayViewModel(
      {@required EmployeeDetailsService employeeDetailsService,
      @required TimeStampService timeStampService,
      @required DateTime dateTime})
      : _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService,
        _dateTime = dateTime;

  /// [EmployeeDetailsService] to edit amount of flex days in
  /// [EmployeeDetails].
  final EmployeeDetailsService _employeeDetailsService;
  final TimeStampService _timeStampService;

  /// Current selected datetime for applied flex day.
  DateTime _dateTime = DateTime.now();

  /// Return [_dateTime].
  DateTime get dateTime => _dateTime;

  ///Set [_dateTime] and notify all ui listeners to rebuild.
  set dateTime(DateTime value) {
    _dateTime = value;
    notifyListeners();
  }

  /// Return flex time of the current logged in employee in [EmployeeDetails].
  double get flexTime =>
      _employeeDetailsService.employeeDetails.currentWorkDetails.flexTime;

  /// Return contract work hours from the current logged in employee.
  double get workHours =>
      _employeeDetailsService.employeeDetails.contractDetails.workHours / 5;

  /// Return [EmployeeDetails] from the current logged in employee.
  EmployeeDetails get employeeDetails =>
      _employeeDetailsService.employeeDetails;

  /// Stamp flex day in [_timeStampService].
  Future stampFlexDay() async {
    if (workHours > flexTime) {
      throw Exception();
    } else {
      await _timeStampService
          .applyAbsence(TimeStampType.flexDay, _dateTime, _dateTime)
          .then((value) {
        _employeeDetailsService.employeeDetails.currentWorkDetails.flexTime -=
            workHours;
      });
    }
  }
}
