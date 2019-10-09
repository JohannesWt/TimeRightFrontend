import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/calendar_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/date_calculator.dart';

class CalendarViewModel extends BaseModel {
  CalendarViewModel({@required CalendarService calendarService})
      : _calendarService = calendarService;

  final CalendarService _calendarService;

  EventList<Event> _eventList = EventList<Event>();

  EventList<Event> get eventList => _eventList;

  void setEventList() {
    _calendarService.timeStampList.forEach((timeStampDay) {
      _eventList.add(
          timeStampDay.date,
          Event(
            date: timeStampDay.date,
            title: 'Test',
            icon: Icon(Icons.add),
            dot: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              color: gray4,
              height: 5.0,
              width: 5.0,
            ),
          ));
    });
    notifyListeners();
  }

  Future fetchTimeStampDaysForMonth(
      String employeeID, int month, int year) async {
    setBusy(true);
    await _calendarService.fetchTimeStampDaysForMonth(employeeID, month, year);
    setBusy(false);
  }

  bool isDayInList(DateTime dateTime) {
    List<TimeStampDay> list = _calendarService.timeStampList
        .where((day) => DateCalculator.isOnSameDay(day.date, dateTime))
        .toList();
    if (list.isNotEmpty) {
      return true;
    }
    return false;
  }

  DateTime _currentSelectedDay = DateTime.now();

  DateTime get currentSelectedDay => _currentSelectedDay;

  set currentSelectedDay(DateTime value) {
    _currentSelectedDay = value;
    notifyListeners();
  }

  int _currentSelectedMonth = DateTime.now().month;

  set currentSelectedMonth(int value) {
    _currentSelectedMonth = value;
    print('Current month: $_currentSelectedMonth');
    notifyListeners();
  }
}
