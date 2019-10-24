/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

/// Model which handles the business logic behind the [TimeStampView].
class TimeStampViewModel extends BaseModel {
  /// Constructor:
  /// Get current list of [TimeStampEvent] for the [_stampTime].
  /// If the last item in the list equals [TimeStampType.stampIn], set the default
  /// value in the [TimeStampView] to [TimeStampType.stampOut] else the other
  /// way round.
  TimeStampViewModel(
      {@required TimeStampService timeStampService,
      EmployeeDetailsService employeeDetailsService})
      : _timeStampService = timeStampService,
        _employeeDetailsService = employeeDetailsService {
    List<TimeStampEvent> tmpList =
        _timeStampService.getTimeStampEventsForDay(_stampTime);
    if (tmpList.isNotEmpty) {
      if (tmpList.first.timeStampType == TimeStampType.stampIn) {
        _currentSelected = TimeStampType.stampOut;
      }
    }
  }

  /// [TimeStampService] to handle the stamp process.
  TimeStampService _timeStampService;

  /// [EmployeeDetailsService] to configure [CurrentWorkDetails] of the
  /// logged in employee after a stamp in our out.
  EmployeeDetailsService _employeeDetailsService;

  /// Return [stampFailsSum] over the whole period.
  int get stampFailsSum =>
      _employeeDetailsService.employeeDetails.stampFailsSum;

  /// Time displayed in the ui as the current stamp time.
  DateTime _stampTime = DateTime.now();

  /// Return [_stampTime].
  DateTime get stampTime => _stampTime;

  /// Return [workHours] to get the calculated workhours from [_timeStampService]
  /// to show it on the stamp out view.
  Duration get workHours => _timeStampService.calculateWorkHours(_stampTime);

  /// Hold the current selected view (stamp in or stamp out)
  TimeStampType _currentSelected = TimeStampType.stampIn;

  /// Return [_currentSelected].
  TimeStampType get currentSelected => _currentSelected;

  ///Change [_currentSelected] to the opposite stamp type. E.g. after a button
  ///click.
  ///Notify all listeners depending on this information to rebuild the ui.
  void changeTimeStampType() {
    _currentSelected = _currentSelected == TimeStampType.stampOut
        ? TimeStampType.stampIn
        : TimeStampType.stampOut;
    notifyListeners();
  }

  /// Check the [_currentSelected] type.
  /// --> call stampIn or stampOut of [_timeStampService].
  ///
  /// Return a [TimeStampResponse].
  Future<TimeStampResponse> stamp(DateTime dateTime) async {
    TimeStampResponse timeStampResponse = TimeStampResponse.unknownResult;
    if (_currentSelected == TimeStampType.stampIn) {
      timeStampResponse = await _timeStampService.stampIn(dateTime);
    } else {
      timeStampResponse = await _timeStampService.stampOut(dateTime);
    }
    return timeStampResponse;
  }
}
