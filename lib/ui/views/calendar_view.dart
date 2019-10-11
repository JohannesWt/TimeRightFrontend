import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/viewmodels/views/base_widget.dart';
import 'package:time_right/core/viewmodels/views/calendar_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/string_formatter.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarViewModel _calendarViewModel;

  EventList<Event> _markedDateMap = EventList<Event>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: CalendarViewModel(calendarService: Provider.of(context)),
      child: AppBar(
        title: Text('Kalender'),
      ),
      onModelReady: (model) async {
        _calendarViewModel = model;
        await _calendarViewModel.fetchTimeStampDaysForMonth(
            Provider.of<Employee>(context).employeeID,
            DateTime.now().month,
            DateTime.now().year);
        _calendarViewModel.setEventList();
        _markedDateMap = _calendarViewModel.eventList;
//        _markedDateMap.addAll(new DateTime(2019, 10, 11), [
//          new Event(
//            date: new DateTime(2019, 10, 11),
//            title: 'Event 1',
//          ),
//        ]);
      },
      builder: (model, context, child) => Center(
        child: Scaffold(
          appBar: child,
          body: _calendarViewModel.busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    buildCalendar(),
                    Text(StringFormatter.getFormattedShortDateString(
                        _calendarViewModel.currentSelectedDay))
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildCalendar() {
    return CalendarCarousel<Event>(
      height: 330,
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
      onDayPressed: (dateTime, eventList) =>
          _calendarViewModel.currentSelectedDay = dateTime,
      weekendTextStyle: TextStyle(color: green2),
//      customDayBuilder: _buildCustomDay,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: false,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: false,
//      markedDateWidget: Container(
//        margin: EdgeInsets.symmetric(horizontal: 4.0),
//        color: gray4,
//        height: 5.0,
//        width: 5.0,
//      ),
//      markedDateIconBuilder: (event) {
//        return event.dot;
//      },
    );
  }

  Widget _buildCustomDay(
      bool isSelectable,
      int index,
      bool isSelectedDay,
      bool isToday,
      bool isPrevMonthDay,
      TextStyle textStyle,
      bool isNextMonthDay,
      bool isThisMonthDay,
      DateTime day) {
    print('Datum : $day');
    if (_calendarViewModel.isDayInList(day)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('${day.day}'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              color: gray4,
              height: 5.0,
              width: 5.0,
            ),
          ],
        ),
      );
    }
//    else {
//      return Center(
//        child: Text('${day.day}'),
//      );
//    }
    return null;
  }
}
