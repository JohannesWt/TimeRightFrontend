/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/views/home_view.dart';

/// Models which handles the business logic of [SickDayView].
class SickDayViewModel extends BaseModel {
  SickDayViewModel(
      {@required EmployeeDetailsService employeeDetailsService,
      @required TimeStampService timeStampService,
      @required DateTime initialDate})
      : _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService,
        _sickDayDate = initialDate;

  /// [EmployeeDetailsService] for updating amount of sick days in [EmployeeDetails].
  final EmployeeDetailsService _employeeDetailsService;

  /// [TimeStampService] for adding a [TimeStampEvent] to [_timeStampService.timeStampMap].
  final TimeStampService _timeStampService;

  /// Return [EmployeeDetails] for redirecting to the [HomeView].
  EmployeeDetails get employeeDetails =>
      _employeeDetailsService.employeeDetails;

  /// Current selected day.
  DateTime _sickDayDate;

  /// Return [_sickDayDate].
  DateTime get sickDayDate => _sickDayDate;

  ///Set [_sickDayDate] and notify all ui listeners to rebuild.
  set sickDayDate(DateTime value) {
    _sickDayDate = value;
    notifyListeners();
  }

  /// Stamp sick day in [_timeStampService].
  Future stampSickDay() async {
    await _timeStampService
        .stampAbsence(TimeStampType.sickDay, _sickDayDate, _sickDayDate)
        .then((value) {
      _employeeDetailsService
          .employeeDetails.currentWorkDetails.sickDaysCurrentMonth += 1;
    });
  }
}
