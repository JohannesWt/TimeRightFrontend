import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/employee_profile/employee_profile.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';

class Api {
  static const endpoint = 'https://www.webjump.pro/api/timetracking/';

  var client = new http.Client();

  /// Get main Employee information from employeeID
  Future<Employee> fetchEmployee(String employeeID) async {
    // TODO: Connect to backend
    var response = await rootBundle.loadString('assets/employee.json');
    print(response);
    // Delay
    await Future.delayed(Duration(seconds: 1));
    Map dataMap = jsonDecode(response);
    return Employee.fromJson(dataMap);
  }

  /// Get currentWork Details from Employee
  Future<EmployeeDetails> fetchEmployeeDetails(String employeeID) async {
    // TODO: Connect to backend
    var response = await rootBundle.loadString('assets/employeeDetails.json');
    await Future.delayed(Duration(seconds: 1));
    print(response);
    Map dataMap = jsonDecode(response);
    return EmployeeDetails.fromJson(dataMap);
  }

  /// Get detailed Employee Profile information
  Future<EmployeeProfile> fetchEmployeeProfile(String employeeID) async {
    // TODO: Connect to backend
    var response = await rootBundle.loadString('assets/employeeDetails.json');
    await Future.delayed(Duration(seconds: 1));
    print(response);
    Map dataMap = jsonDecode(response);
    return EmployeeProfile.fromJson(dataMap);
  }

  Future<List<TimeStampDay>> fetchTimeStampDaysForMonth(
      String employeeID, int month, int year) async {
    // TODO: Connect to backend
    var response = await rootBundle.loadString('assets/calendar.json');
    await Future.delayed(Duration(seconds: 1));
    print(response);
    List<TimeStampDay> timeStampList = jsonDecode(response)
        .map<TimeStampDay>((json) => TimeStampDay.fromJson(json))
        .toList();
    print(timeStampList.first.date);
    return timeStampList;
  }
}
