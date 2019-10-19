import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';

class Api {
  static const endpoint = 'https://api.webjump.pro/timetracking';

  var client = http.Client();

  Map<String, String> headers = {};

  void setCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  /// Get main Employee information from employeeID
  Future<Employee> fetchEmployee(String employeeID, String password) async {
    // TODO: Remove testUser
    String employeeTest = 'testUser';
    String passwordTest = 'test';
    var response = await http.post('$endpoint/login',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: '{"username" : "$employeeTest", "password" : "$passwordTest"}');
    print(response.body);
    setCookie(response);
    print(response.headers);
    Map dataMap = jsonDecode(response.body);
    return Employee.fromJson(dataMap);
  }

  /// Get currentWork Details from Employee
  Future<EmployeeDetails> fetchEmployeeDetails(int employeeID) async {
    // TODO: Connect to backend
    var response = await http.get('$endpoint/startPage', headers: headers);
//    var response = await rootBundle.loadString('assets/employeeDetails.json');
//    await Future.delayed(Duration(seconds: 1));
    print(response.body);
    print(response.headers);
    Map dataMap = jsonDecode(response.body);
    return EmployeeDetails.fromJson(dataMap);
  }

//  /// Get detailed Employee Profile information
//  Future<EmployeeProfile> fetchEmployeeProfile(String employeeID) async {
//    // TODO: Connect to backend
//    var response = await rootBundle.loadString('assets/employeeDetails.json');
////    await Future.delayed(Duration(seconds: 1));
//    print(response);
//    Map dataMap = jsonDecode(response);
//    return EmployeeProfile.fromJson(dataMap);
//  }

  Future<Map<DateTime, List<TimeStampEvent>>> fetchTimeStampDaysForMonth(
      int employeeID, DateTime dateTime) async {
    // TODO: Connect to backend
//    var response = await http.get('$endpoint/calendarData?date=$dateTime', headers: headers);
    var response = await rootBundle.loadString('assets/calendar.json');
    Map<DateTime, List<TimeStampEvent>> dataMap = {};
    List<TimeStampDay> timeStampList = jsonDecode(response)
        .map<TimeStampDay>((json) => TimeStampDay.fromJson(json))
        .toList();
    timeStampList.forEach((timeStampDay) {
      dataMap[timeStampDay.date] = timeStampDay.timeStampEvents;
    });
    return dataMap;
  }
}
