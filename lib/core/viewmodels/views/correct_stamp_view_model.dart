/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/shared/string_formatter.dart';

/// Model which handles the business logic for the [CorrectStampView]
class CorrectStampViewModel extends BaseModel {
  CorrectStampViewModel(
      {@required EmployeeDetailsService employeeDetailsService,
      @required TimeStampService timeStampService,
      @required TimeStampEvent timeStampEvent})
      : _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService,
        _timeStampEvent = timeStampEvent,
        _timeStampType = timeStampEvent.timeStampType,
        _correctStampDate = timeStampEvent.dateTime;

  final TimeStampEvent _timeStampEvent;

  /// [EmployeeDetailsService] for redirecting to the home screen.
  final EmployeeDetailsService _employeeDetailsService;

  /// Return [EmployeeDetails] for navigating back to the home screen.
  EmployeeDetails get employeeDetails =>
      _employeeDetailsService.employeeDetails;

  /// [TimeStampService] for adding a new time stamp event.
  final TimeStampService _timeStampService;

  /// Current time stamp type. (stampOut or stampIn)
  TimeStampType _timeStampType;

  /// Return [_timeStampType].
  TimeStampType get timeStampType => _timeStampType;

  ///Set [_timeStampType] and notify all ui listeners to rebuild.
  set timeStampType(TimeStampType value) {
    _timeStampType = value;
    notifyListeners();
  }

  /// Current selected date to correct a stamp.
  DateTime _correctStampDate;

  /// Return [_correctStampTime].
  DateTime get correctStampDate => _correctStampDate;

  /// Return [correctStampDateString] to show string of [_correctStampTime] on
  /// the ui.
  String get correctStampDateString =>
      StringFormatter.getFormattedShortDateString(_correctStampDate);

  ///Set [_correctStampTime] and notify all ui listeners to rebuild.
  set correctStampDate(DateTime value) {
    _correctStampDate = value;
    notifyListeners();
  }

  /// Current selected time to correct a stamp.
  TimeOfDay _correctStampTime = TimeOfDay.now();

  /// Return [_correctStampTime].
  TimeOfDay get correctStampTime => _correctStampTime;

  ///Set [_correctStampTime] and notify all ui listeners to rebuild.
  set correctStampTime(TimeOfDay value) {
    _correctStampTime = value;
    notifyListeners();
  }

  ///Change [_timeStampType] to the opposite stamp type. E.g. after a button
  ///click.
  ///Notify all listeners depending on this information to rebuild the ui.
  void changeTimeStampType() {
    _timeStampType = _timeStampType == TimeStampType.stampOutFail
        ? TimeStampType.stampInFail
        : TimeStampType.stampOutFail;
    notifyListeners();
  }

  /// Send a corrected stamp view to the backend.
  Future correctStamp() async {
    DateTime dateTime = DateTime(
        _correctStampDate.year,
        _correctStampDate.month,
        _correctStampDate.day,
        _correctStampTime.hour,
        _correctStampTime.minute);
    _timeStampEvent.dateTime = dateTime;
    await _timeStampService.correctStamp(
        _timeStampEvent);
  }
}
