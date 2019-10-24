/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/date_calculator.dart';
import 'package:time_right/ui/views/calendar_view.dart';

/// Model for the [CalendarView], which handles the business logic for
/// the view.
class CalendarViewModel extends BaseModel {
  CalendarViewModel({@required TimeStampService calendarService})
      : _timeStampService = calendarService;

  /// [TimeStampService] to get access to the [_timeStampService.timeStampMap].
  final TimeStampService _timeStampService;

  /// Current selected day of the [CalendarView] widget.
  DateTime _currentSelectedDay = DateTime.now();

  /// Return the [_currentSelectedDay].
  DateTime get currentSelectedDay => _currentSelectedDay;

  /// Set a new [_currentSelectedDay] and notify all widgets depending on it.
  set currentSelectedDay(DateTime value) {
    _currentSelectedDay = value;
    notifyListeners();
  }

  /// Int of the [_currentSelectedMonth].
  int _currentSelectedMonth = DateTime.now().month;

  /// Return [_currentSelectedDay].
  int get currentSelectedMonth => _currentSelectedMonth;

  /// Set a new [_currentSelectedMonth] and notify all widgets depending on it.
  set currentSelectedMonth(int value) {
    _currentSelectedMonth = value;
    notifyListeners();
  }

  /// Special list to show dots under a date on which is a time stamp event.
  EventList<Event> _eventList = EventList<Event>();

  /// Return [_eventList].
  EventList<Event> get eventList => _eventList;

  /// Set time stamp events for month of [dateTime] for a [employeeID] from
  /// in [_timeStampService].
  Future fetchTimeStampDaysForMonth(int employeeID, DateTime dateTime) async {
    setBusy(true);
    await _timeStampService.fetchTimeStampDaysForMonth(employeeID, dateTime);
    notifyListeners();
    setBusy(false);
  }

  /// For every value in [_timeStampService.timeStampMap] add a event [_eventList]
  /// to show the dot under the date on the calendar widget.
  ///
  /// To choose between the dot color red (on the day is a stamp fail located)
  /// and green (everything is ok)
  /// --> look up if a stamp fail is located on that certain day with
  /// [_timeStampService.isFailInTimeStampEventList(timeStampEventList)].
  void setEventList() {
    _timeStampService.timeStampMap.forEach((dateTime, timeStampEventList) {
      Event event = Event(
        date: dateTime.toLocal(),
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: _timeStampService.isFailInTimeStampEventList(timeStampEventList)
              ? mainRed
              : green2,
          height: 5.0,
          width: 5.0,
        ),
      );
      _eventList.add(dateTime.toLocal(), event);
    });
  }

  /// Check if floating action button (fab) should be shown on the calendar vie.
  /// Fab-Button should only be visible if the [_currentSelectedDay] is today´s
  /// date are after today.
  ///
  /// --> It is not possible to apply an absence day after today´s date.
  bool checkDates(DateTime dateTime) {
    return ((currentSelectedDay.compareTo(dateTime) > 0) ||
        DateCalculator.isOnSameDay(currentSelectedDay, dateTime));
  }
}
