/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

/// Model which handles the business logic of [TimeStampsListModel].
class TimeStampsListModel extends BaseModel {
  TimeStampsListModel({@required TimeStampService timeStampService})
      : _timeStampService = timeStampService;

  /// [TimeStampService] to get the current time stamp list.
  final TimeStampService _timeStampService;

  /// Currently display list of [TimeStampEvent]s.
  List<TimeStampEvent> _currentTimeStampEventList;

  /// Return [_currentTimeStampEventList]
  List<TimeStampEvent> get currentTimeStampEventList =>
      _currentTimeStampEventList;

  /// Currently displayed date.
  DateTime _currentTimeStampDay = DateTime.now();

  /// Return  [_currentTimeStampDay].
  DateTime get currentTimeStampDay => _currentTimeStampDay;

  /// Set new [_currentTimeStampDay] and notify all ui listeners depending
  /// on this information to rebuild itself.
  set currentTimeStampDay(DateTime value) {
    _currentTimeStampDay = value;
    setCurrentTimeStampEventList();
    notifyListeners();
  }

  /// Set the [_currentTimeStampEventList] to the currently displayed
  /// [_currentTimeStampDay].
  void setCurrentTimeStampEventList() {
    _currentTimeStampEventList =
        _timeStampService.getTimeStampEventsForDay(_currentTimeStampDay);
    notifyListeners();
  }

  /// Change the [_currentTimeStampDay] to the next day and notify all ui
  /// listeners depending on that information to rebuild itself.
  void setNextDay() {
    _currentTimeStampDay = _currentTimeStampDay.add(Duration(days: 1));
    setCurrentTimeStampEventList();
    notifyListeners();
  }

  /// Change the [_currentTimeStampDay] to the previous day and notify all ui
  /// listeners depending on that information to rebuild itself.
  void setPreviousDay() {
    _currentTimeStampDay = _currentTimeStampDay.subtract(Duration(days: 1));
    setCurrentTimeStampEventList();
    notifyListeners();
  }
}
