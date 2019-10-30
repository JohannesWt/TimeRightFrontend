/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';
import 'package:time_right/app_localizations.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/ui/views/base_widget.dart';
import 'package:time_right/core/viewmodels/views/calendar_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/string_formatter.dart';
import 'package:time_right/ui/widgets/time_stamps_list.dart';

/// Class building the calendar widget.
class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  /// [_calendarViewModel] handles the logic behind this view.
  CalendarViewModel _calendarViewModel;

  /// [TimeStampsList] widget beneath the calendar widget.
  TimeStampsList _timeStampsList;

  /// Build calendar view with calendar widget and time stamp list beneath it.
  @override
  Widget build(BuildContext context) {
    return BaseWidget<CalendarViewModel>(
      model: CalendarViewModel(calendarService: Provider.of(context)),
      child: AppBar(
        title: Text('Kalender'),
        leading: IconButton(
            onPressed: () {
              _calendarViewModel.currentSelectedDay = DateTime.now();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      onModelReady: (model) async {
        _calendarViewModel = model;
        await _calendarViewModel.fetchTimeStampDaysForMonth(
            Provider.of<Employee>(context).employeeID, DateTime.now());
        _calendarViewModel.setEventList();
        _timeStampsList = TimeStampsList(
          showHeader: false,
        );
      },
      builder: (context, model, child) => Scaffold(
        appBar: child,
        body: _calendarViewModel.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  _buildCalendar(),
                  FlatButton(
//                      padding: const EdgeInsets.all(0),
                    onPressed: () {
                      _calendarViewModel.currentSelectedDay = DateTime.now();
                      _timeStampsList.setCurrentTimeStampDay(DateTime.now());
                    },
                    child: Text(
                        StringFormatter.getFormattedShortDateString(
                            _calendarViewModel.currentSelectedDay),
                        style: Theme.of(context).textTheme.title),
                  ),
                  Expanded(
                    child: _timeStampsList,
                  )
                ],
              ),
        floatingActionButton: _calendarViewModel.checkDates(DateTime.now())
            ? _buildFloatingActionButton()
            : Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  /// Build floating action button
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(
          context, RoutePaths.absenceChoiceView,
          arguments: _calendarViewModel.currentSelectedDay),
    );
  }

  /// Build calendar widget.
  Widget _buildCalendar() {
    return CalendarCarousel<Event>(
        locale: AppLocalizations.of(context).locale.languageCode,
        height: 360,
        thisMonthDayBorderColor: gray2,
        headerMargin: EdgeInsets.all(0),
        headerTextStyle: TextStyle(color: gray4, fontSize: 16),
        weekdayTextStyle: TextStyle(color: gray4, fontSize: 10),
        iconColor: gray4,
        showHeaderButton: true,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        selectedDateTime: _calendarViewModel.currentSelectedDay,
        selectedDayButtonColor: blueAccent,
        todayButtonColor: gray2,
        onCalendarChanged: (dateTime) {
          _calendarViewModel.currentSelectedMonth = dateTime.month;
        },
        daysTextStyle: TextStyle(fontFamily: 'Porsche_Next', color: gray4),
        selectedDayTextStyle: TextStyle(color: white),
        onDayPressed: (dateTime, eventList) {
          _timeStampsList.setCurrentTimeStampDay(dateTime);
          _calendarViewModel.currentSelectedDay = dateTime;
        },
        weekendTextStyle: TextStyle(color: orange1),
        markedDatesMap: _calendarViewModel.eventList,
        onDayLongPressed: (dateTime) {
          if (_calendarViewModel.checkDates(dateTime)) {
            Navigator.pushNamed(context, RoutePaths.absenceChoiceView,
                arguments: _calendarViewModel.currentSelectedDay);
          }
        });
  }
}
