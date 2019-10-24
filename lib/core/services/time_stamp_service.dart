/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'dart:async';

import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/api.dart';
import 'package:time_right/ui/shared/date_calculator.dart';

/// Depends on [Api] and handles the stamp processes.
class TimeStampService {
  TimeStampService({Api api}) : _api = api;

  final Api _api;

  /// Key is a [DateTime] and value is a List of all [TimeStampEvent] for that
  /// date.
  Map<DateTime, List<TimeStampEvent>> _timeStampMap = {};

  /// Return [_timeStampMap].
  Map<DateTime, List<TimeStampEvent>> get timeStampMap => _timeStampMap;

  /// Is true if a new [TimeStampEvent] gets added to the [_timeStampMap].
  bool _newStamp = true;

  /// Fetch time stamp days for the month of [dateTime] and ad all to the
  /// [_timeStampMap].
  Future fetchTimeStampDaysForMonth(int employeeID, DateTime dateTime) async {
    Map<DateTime, List<TimeStampEvent>> tmpMap =
        await _api.fetchTimeStampDaysForMonth(employeeID, dateTime);
    _timeStampMap.addAll(tmpMap);
  }

  /// Calculate suitable UTC-DateTime for [compDate].
  /// If [_timeStampMap] contains [compDate] return the suitable List of the
  /// key. Otherwise return an empty list.
  /// Return list of [TimeStampEvent] for a specified [compDate].
  List<TimeStampEvent> getTimeStampEventsForDay(DateTime compDate) {
    DateTime formattedDateTime =
        DateCalculator.shortFormDateTime(compDate).toUtc();
    if (_timeStampMap.containsKey(formattedDateTime)) {
      _timeStampMap[formattedDateTime]
          .sort((a, b) => b.dateTime.compareTo(a.dateTime));
      return _timeStampMap[formattedDateTime];
    } else {
      return [];
    }
  }

  /// Calculate suitable UTC DateTime for [newDate].
  /// If the key for [newDate] is already in [_timeStampMap] add a new
  /// [TimeStampEvent] with the specified [newDate] and [timeStampType].
  /// Otherwise add a new key to the [_timeStampMap] and insert the new
  /// [TimeStampEvent] to the values.
  void _addTimeStampEvent(DateTime newDate, TimeStampType timeStampType) {
    DateTime dateTime = DateCalculator.shortFormDateTime(newDate).toUtc();
    TimeStampEvent newEvent =
        TimeStampEvent(timeStampType: timeStampType, dateTime: newDate);
    if (timeStampMap[dateTime] == null) {
      timeStampMap[dateTime] = [newEvent];
    } else {
      timeStampMap[dateTime].add(newEvent);
    }
  }

  /// Check if there is a stamp fail included in [timeStampEventList]
  bool isFailInTimeStampEventList(List<TimeStampEvent> timeStampEventList) {
    for (TimeStampEvent timeStampEvent in timeStampEventList) {
      if (timeStampEvent.timeStampType == TimeStampType.stampInFail ||
          timeStampEvent.timeStampType == TimeStampType.stampOutFail) {
        return true;
      }
    }
    return false;
  }

  /// Calculated current work hours of the logged in employee.
  Duration _workHours = Duration();

  /// Return [_workHours].
  Duration get workHours => _workHours;

  /// If a new [TimeStampEvent] had been added to the [_timeStampMap] recalculate
  /// [_workHours]. Other wise return current [_workHours].
  ///
  /// To calculate new [_workHours] --> get the list of [TimeStampEvent] for the
  /// specified [compDate].
  /// If the list has more than one entry. Loop over every item.
  /// (The list is ordered descending by the date.)
  /// In the loop:
  ///
  ///   If the current [TimeStampEvent] has a [TimeStampType.stampIn] and the next
  ///   a [TimeStampType.stampOut]
  ///   --> Employee stamped in and out ofter. (Be aware of the order of the list)
  ///   --> Add the Duration between those two dates to [_workHours].
  ///   --> Set [_newStamp] to false to not recalculate [_workHours] if there
  ///   is no new [TimeStampEvent] added to [_timeStampMap].
  ///
  ///   If the last (index = 0) [TimeStampEvent] has a [TimeStampType.stampIn]
  ///   --> The employee is still stamped in.
  ///   --> Add the Duration between stampIn date and the current [compDate].
  ///   --> Set [_newStamp] to true to recalculate [_workHours], because employee
  ///   is currently stamped in which increases [_workHours] constantly.
  ///
  /// If the list has only one entrie:
  /// --> Check if the last time stamp type is a [TimeStampType.stampIn].
  /// --> Add the Duration between stampIn date and the current [compDate].
  /// --> Set [_newStamp] to true to recalculate [_workHours], because employee
  ///   is currently stamped in which increases [_workHours] constantly.
  ///
  /// Return [_workHours].
  Duration calculateWorkHours(DateTime compDate) {
    if (_newStamp) {
      _workHours = Duration();
      List<TimeStampEvent> tmpList = getTimeStampEventsForDay(compDate);
      if (tmpList.length > 1) {
        for (int i = tmpList.length - 2; i >= 0; i--) {
          if (tmpList[i].timeStampType == TimeStampType.stampOut &&
              tmpList[i + 1].timeStampType == TimeStampType.stampIn) {
            _workHours = _workHours +
                tmpList[i].dateTime.difference(tmpList[i + 1].dateTime);
            _newStamp = false;
          } else if (i == 0 &&
              tmpList[i].timeStampType == TimeStampType.stampIn) {
            _workHours = _workHours + compDate.difference(tmpList[i].dateTime);
            _newStamp = true;
          }
        }
      } else if (tmpList.length == 1 &&
          tmpList.first.timeStampType == TimeStampType.stampIn) {
        _workHours = compDate.difference(tmpList.first.dateTime);
        _newStamp = true;
      }
    }
    return _workHours;
  }

  /// Set expected response to [TimeStampResponse.stampInSuccess].
  /// Set response to the result of [_checkLastEventFail]
  /// If response still equals [TimeStampResponse.stampInSuccess]:
  ///   --> Set response to the result [_checkWorkDay].
  ///   If response still equals [TimeStampResponse.stampInSuccess]:
  ///     --> Call the stamp method from [_api] and add a call [_addTimeStampEvent].
  ///     --> After adding a new [TimeStampEvent]
  ///
  /// Return the calculated response.
  Future<TimeStampResponse> stampIn(DateTime dateTime) async {
    TimeStampResponse timeStampResponse = TimeStampResponse.stampInSuccess;
    timeStampResponse = _checkLastEventFail(dateTime, timeStampResponse);
    if (timeStampResponse == TimeStampResponse.stampInSuccess) {
      timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
      if (timeStampResponse == TimeStampResponse.stampInSuccess) {
        _api.stamp(dateTime, TimeStampType.stampIn);
        _addTimeStampEvent(dateTime, TimeStampType.stampIn);
        print(_timeStampMap);
        _newStamp = true;
      }
    }
    return timeStampResponse;
  }

//  // TODO: stamp in for Validation
//  TimeStampResponse stampInForValidation(DateTime dateTime) {
//    TimeStampResponse timeStampResponse =
//        TimeStampResponse.stampInForValidation;
//    timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
//    if (timeStampResponse != TimeStampResponse.stampWorkDayFail) {
//      getTimeStampEventsForDay(dateTime).add(TimeStampEvent(
//          dateTime: dateTime, timeStampType: TimeStampType.stampInValidation));
//    }
//    return timeStampResponse;
//  }

  // TODO: stamp out for Validation
  TimeStampResponse stampOutForValidation(DateTime dateTime) {
    TimeStampResponse timeStampResponse =
        TimeStampResponse.stampOutForValidation;
    timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
    if (timeStampResponse != TimeStampResponse.stampWorkDayFail) {
      getTimeStampEventsForDay(dateTime).add(TimeStampEvent(
          dateTime: dateTime, timeStampType: TimeStampType.stampOutValidation));
    }
    return timeStampResponse;
  }

  /// Works similar to [stampIn] with the difference that the expected response
  /// is [TimeStampResponse.stampOutSuccess].
  Future<TimeStampResponse> stampOut(DateTime dateTime) async {
    TimeStampResponse timeStampResponse = TimeStampResponse.stampOutSuccess;
    timeStampResponse = _checkLastEventFail(dateTime, timeStampResponse);
    if (timeStampResponse == TimeStampResponse.stampOutSuccess) {
      timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
      if (timeStampResponse == TimeStampResponse.stampOutSuccess) {
        // TODO: connect to API
        _addTimeStampEvent(dateTime, TimeStampType.stampOut);
        _newStamp = true;
        return timeStampResponse;
      }
    }
    return timeStampResponse;
  }

  // TODO: Connect to api response
  TimeStampResponse stampVacationForValidation(DateTime dateTime) {
    TimeStampResponse timeStampResponse =
        TimeStampResponse.stampVacationSuccess;
    timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
    if (timeStampResponse != TimeStampResponse.stampWorkDayFail) {
      // TODO: Connect to api
      getTimeStampEventsForDay(dateTime).add(TimeStampEvent(
          dateTime: dateTime, timeStampType: TimeStampType.vacationValidation));
    }
    return timeStampResponse;
  }

  // TODO: Connect to api response
  TimeStampResponse stampFlexDayForValidation(DateTime dateTime) {
    TimeStampResponse timeStampResponse = TimeStampResponse.stampFlexDaySuccess;
    timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
    if (timeStampResponse != TimeStampResponse.stampWorkDayFail) {
      // TODO: Connect to api
      getTimeStampEventsForDay(dateTime).add(TimeStampEvent(
          dateTime: dateTime, timeStampType: TimeStampType.flexDayValidation));
    }
    return timeStampResponse;
  }

  // TODO: Connect to api response
  TimeStampResponse stampSickDay(DateTime dateTime) {
    TimeStampResponse timeStampResponse = TimeStampResponse.stampSickDaySuccess;
    timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
    if (timeStampResponse != TimeStampResponse.stampWorkDayFail) {
      // TODO: Connect to api
      getTimeStampEventsForDay(dateTime).add(TimeStampEvent(
          dateTime: dateTime, timeStampType: TimeStampType.sickDayValidation));
    }
    return timeStampResponse;
  }

  /// Check last event of [getTimeStampEventsForDay] of [dateTime] and.
  /// Check [TimeStampType] of that last event against [sourceResponse].
  ///
  /// Return specified error for [TimeStampType]s.
  /// E.g.:
  ///   --> if last Event type is equal to [TimeStampType.vacation]
  ///     It should not be able to stamp on  a vacation day
  ///     Return [TimeStampResponse.stampVacationFail] etc.
  ///   --> if last Event type is equal to [TimeStampType.stampIn] and the [sourceResponse]
  ///     is equal to [TimeStampResponse.stampInSuccess] the employee tries to
  ///     stamp in while he/she is already stamped in. He/she has to stamp out first.
  ///     Return [TimeStampResponse.stampOutFirst]
  TimeStampResponse _checkLastEventFail(
      DateTime dateTime, TimeStampResponse sourceResponse) {
    List<TimeStampEvent> tmpTimeStampEventList =
        getTimeStampEventsForDay(dateTime);
    if (tmpTimeStampEventList.isNotEmpty) {
      switch (tmpTimeStampEventList.first.timeStampType) {
        case (TimeStampType.vacation):
          return TimeStampResponse.stampVacationFail;
        case (TimeStampType.sickDay):
          return TimeStampResponse.stampSickDayFail;
        case (TimeStampType.flexDay):
          return TimeStampResponse.stampFlexDayFail;
        case (TimeStampType.stampOut):
          if (sourceResponse == TimeStampResponse.stampOutSuccess) {
            return TimeStampResponse.stampInFirstFail;
          } else {
            return sourceResponse;
          }
          break;
        case (TimeStampType.stampIn):
          if (sourceResponse == TimeStampResponse.stampInSuccess) {
            return TimeStampResponse.stampOutFirstFail;
          } else {
            return sourceResponse;
          }
          break;
        default:
          return sourceResponse;
      }
    }
    return sourceResponse;
  }

  /// Check if [dateTime] is a weekday.
  /// If true return [sourceResponse] else [TimeStampResponse.stampWorkDayFail].
  TimeStampResponse _checkWorkDay(
      DateTime dateTime, TimeStampResponse sourceResponse) {
    return (dateTime.weekday == DateTime.saturday ||
            dateTime.weekday == DateTime.sunday)
        ? TimeStampResponse.stampWorkDayFail
        : sourceResponse;
  }
}
