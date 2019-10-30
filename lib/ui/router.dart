/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/viewmodels/views/application_view_model.dart';
import 'package:time_right/ui/views/absence_choice_view.dart';
import 'package:time_right/ui/views/application_view.dart';
import 'package:time_right/ui/views/calendar_view.dart';
import 'package:time_right/ui/views/correct_stamp_view.dart';
import 'package:time_right/ui/views/flex_day_view.dart';
import 'package:time_right/ui/views/home_view.dart';
import 'package:time_right/ui/views/login_view.dart';
import 'package:time_right/ui/views/overview_view.dart';
import 'package:time_right/ui/views/profile_view.dart';
import 'package:time_right/ui/views/sick_day_view.dart';
import 'package:time_right/ui/views/time_stamp_view.dart';
import 'package:time_right/ui/views/vacation_view.dart';

/// Class handles the routing through the app.
/// Depending on the static [RoutePaths] variable it chooses a certain view and
/// navigates to it.
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.loginView:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.homeView:
        var employeeDetails = settings.arguments as EmployeeDetails;
        return MaterialPageRoute(
            builder: (_) => HomeView(
                  employeeDetails: employeeDetails,
                ));
      case RoutePaths.calendarView:
        return MaterialPageRoute(builder: (_) => CalendarView());
      case RoutePaths.absenceChoiceView:
        var dateTime = settings.arguments as DateTime;
        return MaterialPageRoute(
            builder: (_) => AbsenceChoiceView(
                  dateTime: dateTime,
                ));
      case RoutePaths.profileView:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case RoutePaths.overviewView:
        var employeeDetails = settings.arguments as EmployeeDetails;
        return MaterialPageRoute(
          builder: (_) => OverviewView(
            employeeDetails: employeeDetails,
          ),
        );
      case RoutePaths.timeStampView:
        return MaterialPageRoute(builder: (_) => TimeStampView());
      case RoutePaths.vacationView:
        var startDate = settings.arguments as DateTime;
        return MaterialPageRoute(
            builder: (_) => VacationView(
                  startDate: startDate,
                ));
      case RoutePaths.flexDayView:
        var dateTime = settings.arguments as DateTime;
        return MaterialPageRoute(
            builder: (_) => FlexDayView(
                  dateTime: dateTime,
                ));
      case RoutePaths.sickDayView:
        var dateTime = settings.arguments as DateTime;
        return MaterialPageRoute(
            builder: (_) => SickDayView(
                  initialDate: dateTime,
                ));
      case RoutePaths.correctStampView:
        var list = settings.arguments as List;
        var date = list[0] as DateTime;
        var timeStampType = list[1] as TimeStampType;
        print(timeStampType);
        return MaterialPageRoute(
            builder: (_) => CorrectStampView(
                  initialDate: date,
                  initialStampType: timeStampType,
                ));
      case RoutePaths.applicationView:
        return MaterialPageRoute(builder: (_) => ApplicationView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
