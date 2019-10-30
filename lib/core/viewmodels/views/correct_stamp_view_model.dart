/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      @required TimeStampType timeStampType,
      @required DateTime correctStampDate})
      : _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService,
        _timeStampType = timeStampType,
        _correctStampDate = correctStampDate;

  /// [EmployeeDetailsService] for redirecting to the home screen.
  final EmployeeDetailsService _employeeDetailsService;

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
    _timeStampType = _timeStampType == TimeStampType.stampOut
        ? TimeStampType.stampIn
        : TimeStampType.stampOut;
    notifyListeners();
  }
}
