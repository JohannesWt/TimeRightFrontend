import 'package:flutter/material.dart';
import 'package:time_right/ui/widgets/calendar.dart';

class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalender')),
      body: Calendar(),
    );
  }
}
