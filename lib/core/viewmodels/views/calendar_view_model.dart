import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/shared/colors.dart';

class CalendarViewModel extends BaseModel {
  CalendarViewModel({@required TimeStampService calendarService})
      : _calendarService = calendarService;

  final TimeStampService _calendarService;

  DateTime _currentSelectedDay = DateTime.now();

  DateTime get currentSelectedDay => _currentSelectedDay;

  set currentSelectedDay(DateTime value) {
    _currentSelectedDay = value;
    notifyListeners();
  }

  int _currentSelectedMonth = DateTime.now().month;

  int get currentSelectedMonth => _currentSelectedMonth;

  set currentSelectedMonth(int value) {
    _currentSelectedMonth = value;
    setTimeStampEventsForDay();
    notifyListeners();
  }

  List<TimeStampEvent> _currentTimeStampEventList = [];

  List<TimeStampEvent> get currentTimeStampEventList =>
      _currentTimeStampEventList;

  EventList<Event> _eventList = EventList<Event>();

  EventList<Event> get eventList => _eventList;

  Future fetchTimeStampDaysForMonth(
      int employeeID, DateTime dateTime) async {
    setBusy(true);
     await _calendarService.fetchTimeStampDaysForMonth(employeeID, dateTime);
    notifyListeners();
    setBusy(false);
  }

  void setEventList() {
    _calendarService.timeStampMap.forEach((dateTime, timeStampEventList) {
      Event event = Event(
        date: dateTime.toLocal(),
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: _calendarService.isFailInTimeStampEventList(timeStampEventList)
              ? mainRed
              : amber,
          height: 5.0,
          width: 5.0,
        ),
      );
      _eventList.add(dateTime.toLocal(), event);
    });
  }

  void setTimeStampEventsForDay() {
    _currentTimeStampEventList =
        _calendarService.getTimeStampEventsForDay(_currentSelectedDay);
  }
}
