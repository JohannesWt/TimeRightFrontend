/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/shared/string_formatter.dart';
import 'package:time_right/ui/widgets/work_time_clock.dart';

/// Model which handles the business logic of [WorkTimeClock].
class WorkTimeClockModel extends BaseModel {
  /// Constructor
  WorkTimeClockModel(
      {@required EmployeeDetailsService employeeDetailsService,
      @required TimeStampService timeStampService})
      : _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService;

  /// [EmployeeDetailsService] to get the work hours set in the work contract.
  final EmployeeDetailsService _employeeDetailsService;

  /// [TimeStampService] to get the current calculated work hours.
  final TimeStampService _timeStampService;

  /// Timer to recalculate the work hours.
  static Timer workTimer = Timer(Duration(seconds: 1), () => print('Tick'));

//
//  /// Return [_workTimer].
//  Timer get workTimer => _workTimer;

  /// Work hour string displayed in the clock.
  String _workHoursString = '00:00:00';

  /// Return [_workHoursString].
  String get workHoursString => _workHoursString;

  /// Set the percentage how much the clock border is filled.
  double _percentage = 0;

  /// Return [_percentage].
  double get percentage => _percentage;

  @override
  void dispose() {
    workTimer.cancel();
    super.dispose();
  }

  /// Start the work timer to recalculate work hours every second.
  /// --> call [_getWorkHours]
  void startWorkTimer() async {
    _getWorkHours();
    workTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _getWorkHours();
    });
  }

  /// Get the new calculated work hours from [_timeStampService].
  /// Format that [Duration] in a string.
  /// calculate the [_percentage] how much percentage the current work hours
  /// are to the set work hours in the employee contract.
  ///
  /// Notify all ui listeners, which depend on [_percentage] and [_workHoursString]
  /// to rebuild them self.
  void _getWorkHours() {
    Duration workHours = _timeStampService.calculateWorkHours(DateTime.now());
    _workHoursString = StringFormatter.formatDuration(workHours);
    _percentage = (workHours.inSeconds /
        _employeeDetailsService.getContractWorkHours().inSeconds);
    print('Workhours: $_workHoursString');
    notifyListeners();
  }
}
