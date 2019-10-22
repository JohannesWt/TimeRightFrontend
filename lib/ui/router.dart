import 'package:flutter/material.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/ui/views/absence_choice_view.dart';
import 'package:time_right/ui/views/calendar_view.dart';
import 'package:time_right/ui/views/time_stamp_view.dart';
import 'package:time_right/ui/views/home_view.dart';
import 'package:time_right/ui/views/login_view.dart';
import 'package:time_right/ui/views/overview_view.dart';
import 'package:time_right/ui/views/profile_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.loginView:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.homeView:
        var stampFails = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => HomeView(
                  stampFails: stampFails,
                ));
      case RoutePaths.calendarView:
        return MaterialPageRoute(builder: (_) => CalendarView());
      case RoutePaths.absenceChoiceView:
        return MaterialPageRoute(builder: (_) => AbsenceChoiceView());
      case RoutePaths.profileView:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case RoutePaths.overviewView:
        var employeeDetails = settings.arguments as EmployeeDetails;
        return MaterialPageRoute(
            builder: (_) => OverviewView(
                  employeeDetails: employeeDetails,
                ));
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
