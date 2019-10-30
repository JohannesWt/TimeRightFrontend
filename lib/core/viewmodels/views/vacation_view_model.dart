/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/views/home_view.dart';
import 'package:time_right/ui/views/vacation_view.dart';

/// Model which handles the business logic of [VacationView].
class VacationViewModel extends BaseModel {
  VacationViewModel(
      {@required EmployeeDetailsService employeeDetailsService,
      @required TimeStampService timeStampService,
      @required DateTime startDate})
      : _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService,
        _startDate = startDate.add(Duration(days: 1)),
        _endDate = startDate.add(Duration(days: 1));

  /// [EmployeeDetailsService] for editing the amount of vacations in [EmployeeDetails].
  final EmployeeDetailsService _employeeDetailsService;

  /// [TimeStampService] for adding a new [TimeStampEvent] to [_timeStampService.timeStampMap].
  final TimeStampService _timeStampService;

  /// Current selected startDate of applied vacation.
  DateTime _startDate;

  /// Return [_startDate].
  DateTime get startDate => _startDate;

  ///Set [_startDate] and notify all ui listeners to rebuild.
  set startDate(DateTime value) {
    _startDate = value;
    if (_startDate.isAfter(_endDate)) {
      _endDate = value;
    }
    notifyListeners();
  }

  /// Current selected endDate of applied vacation.
  DateTime _endDate;

  /// Return [_endDate].
  DateTime get endDate => _endDate;

  ///Set [_endDate] and notify all ui listeners to rebuild.
  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  /// Return [EmployeeDetails] for redirecting to the [HomeView].
  EmployeeDetails get employeeDetails =>
      _employeeDetailsService.employeeDetails;

  /// Return calculated difference between [_startDate] and [_endDate].
  Duration get selectedDaysSum =>
      _endDate.difference(_startDate) + Duration(days: 1);

  /// Return calculated amount of remaining vacation of the current logged in
  /// employee.
  double get remainingVacation =>
      _employeeDetailsService.employeeDetails.contractDetails.vacation -
      _employeeDetailsService.employeeDetails.currentWorkDetails.takenVacation -
      _employeeDetailsService
          .employeeDetails.currentWorkDetails.appliedVacation;

  /// Stamp vacation in the [_timeStampService].
  Future<TimeStampResponse> stampVacation() async {
    await _timeStampService
        .stampAbsence(TimeStampType.vacation, _startDate, _endDate)
        .then((value) {
      _employeeDetailsService.employeeDetails.currentWorkDetails
          .appliedVacation += selectedDaysSum.inDays;
//      print(selectedDaysSum.inDays);
    });
  }
}
