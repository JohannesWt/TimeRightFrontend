import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:time_right/ui/shared/colors.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarCarousel _calendarCarousel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[buildCalenderCarousel(), Text('Datum: 12.12.2019')],
      ),
    );
  }

  Widget buildCalenderCarousel() {
    return _calendarCarousel = CalendarCarousel<Event>(
      height: 358,
      thisMonthDayBorderColor: gray2,
      headerMargin: EdgeInsets.all(0),
      headerTextStyle: TextStyle(color: gray4, fontSize: 16),
      weekdayTextStyle: TextStyle(color: gray4, fontSize: 10),
      iconColor: gray4,
      showHeaderButton: true,
    );
  }
}
