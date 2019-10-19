import 'dart:async';

import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/api.dart';
import 'package:time_right/ui/shared/date_calculator.dart';

class TimeStampService {
  TimeStampService({Api api}) : _api = api;

  final Api _api;

  Map<DateTime, List<TimeStampEvent>> _timeStampMap = {};

  Map<DateTime, List<TimeStampEvent>> get timeStampMap => _timeStampMap;

  bool _newStamp = true;

  Future fetchTimeStampDaysForMonth(int employeeID, DateTime dateTime) async {
    Map<DateTime, List<TimeStampEvent>> tmpMap =
        await _api.fetchTimeStampDaysForMonth(employeeID, dateTime);
    _timeStampMap.addAll(tmpMap);
  }

  List<TimeStampEvent> getTimeStampEventsForDay(DateTime compDate) {
    DateTime formattedDateTime =
        DateCalculator.shortFormDateTime(compDate).toUtc();
//    print(formattedDateTime.toString());
    if (_timeStampMap.containsKey(formattedDateTime)) {
      _timeStampMap[formattedDateTime]
          .sort((a, b) => b.dateTime.compareTo(a.dateTime));
      return _timeStampMap[formattedDateTime];
    } else {
      return [];
    }
  }

  bool isFailInTimeStampEventList(List<TimeStampEvent> timeStampEventList) {
    for (TimeStampEvent timeStampEvent in timeStampEventList) {
      if (timeStampEvent.timeStampType == TimeStampType.stampInFail ||
          timeStampEvent.timeStampType == TimeStampType.stampOutFail) {
        return true;
      }
    }
    return false;
  }

  Duration _workHours = Duration();

  Duration calculateWorkHour(DateTime compDate) {
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

  Future<TimeStampResponse> stampIn(DateTime dateTime) async {
    TimeStampResponse timeStampResponse = TimeStampResponse.stampInSuccess;
    timeStampResponse = _checkLastEventFail(dateTime, timeStampResponse);
    if (timeStampResponse == TimeStampResponse.stampInSuccess) {
      if (timeStampResponse == TimeStampResponse.stampInSuccess) {
        timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
        // TODO: connect to API
        getTimeStampEventsForDay(dateTime).add(TimeStampEvent(
            dateTime: dateTime, timeStampType: TimeStampType.stampIn));
        _newStamp = true;
        return timeStampResponse;
      }
    }
    return timeStampResponse;
  }

  // TODO: stamp in for Validation
  TimeStampResponse stampInForValidation(DateTime dateTime) {
    TimeStampResponse timeStampResponse =
        TimeStampResponse.stampInForValidation;
    timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
    if (timeStampResponse != TimeStampResponse.stampWorkDayFail) {
      getTimeStampEventsForDay(dateTime).add(TimeStampEvent(
          dateTime: dateTime, timeStampType: TimeStampType.stampInValidation));
    }
    return timeStampResponse;
  }

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

  Future<TimeStampResponse> stampOut(DateTime dateTime) async {
    TimeStampResponse timeStampResponse = TimeStampResponse.stampOutSuccess;
    timeStampResponse = _checkLastEventFail(dateTime, timeStampResponse);
    if (timeStampResponse == TimeStampResponse.stampOutSuccess) {
      if (timeStampResponse == TimeStampResponse.stampOutSuccess) {
        timeStampResponse = _checkWorkDay(dateTime, timeStampResponse);
        // TODO: connect to API
        getTimeStampEventsForDay(dateTime).add(TimeStampEvent(
            dateTime: dateTime, timeStampType: TimeStampType.stampOut));
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

  TimeStampResponse _checkLastEventFail(
      DateTime dateTime, TimeStampResponse sourceResponse) {
    List<TimeStampEvent> tmpTimeStampEventList =
        getTimeStampEventsForDay(dateTime);
    if (tmpTimeStampEventList.isNotEmpty) {
      for (TimeStampEvent timeStampEvent in tmpTimeStampEventList) {
        switch (timeStampEvent.timeStampType) {
          case (TimeStampType.vacation):
            return TimeStampResponse.stampVacationFail;
          case (TimeStampType.sickDay):
            return TimeStampResponse.stampSickDayFail;
          case (TimeStampType.flexDay):
            return TimeStampResponse.stampFlexDayFail;
          case (TimeStampType.stampOut):
            return TimeStampResponse.stampInFirstFail;
          case (TimeStampType.stampIn):
            return TimeStampResponse.stampOutFirstFail;
          // TODO: Missing TimeStampTypes
          default:
            continue;
        }
      }
    }
    return sourceResponse;
  }

  TimeStampResponse _checkWorkDay(
      DateTime dateTime, TimeStampResponse sourceResponse) {
    return (dateTime.weekday == DateTime.saturday ||
            dateTime.weekday == DateTime.sunday)
        ? TimeStampResponse.stampWorkDayFail
        : sourceResponse;
  }
}
