import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:time_right/ui/shared/colors.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: CalendarCarousel<Event>(
        height: 115,
        weekFormat: true,
        thisMonthDayBorderColor: gray2,
        headerMargin: EdgeInsets.all(0),
        headerTextStyle: TextStyle(color: gray4, fontSize: 16),
        weekdayTextStyle: TextStyle(color: gray4, fontSize: 10),
        iconColor: gray4,
        showHeaderButton: true,
      ),
    );
  }
}