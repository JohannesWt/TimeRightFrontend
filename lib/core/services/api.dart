/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/ui/shared/string_formatter.dart';

/// Main service to handle connection to the backend and transfer data it.
class Api {
  /// Endpoint of the backend server.
  static const endpoint = 'https://api.webjump.pro/timetracking';

  /// HttpClient to execute get and post requests to the backend.
  var client = http.Client();

  /// Header for all JSON Api requests.
  Map<String, String> headers = {};

  /// Set cookie in [headers] to save session key of an employee after log in.
  void _setCookie(http.Response response) {
    headers['content-type'] = 'application/json';
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  /// Fetch login employee information for an [employeeID] and the suitable
  /// [password] from the backend.
  /// Calls [_setCookie] to safe the sessionID.
  ///
  /// Return Employee object, decoded from the JSON response.
  Future<Employee> fetchEmployee(String employeeID, String password) async {
    // TODO: Remove testUser
//    String employeeTest = 'testUser';
//    String passwordTest = 'test';
//    var response = await rootBundle.loadString('assets/employee.json');
    var response = await http.post('$endpoint/login',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: '{"username" : "$employeeID", "password" : "$password"}');
    _setCookie(response);
    Map dataMap = jsonDecode(response.body);
    return Employee.fromJson(dataMap);
  }

  /// Fetch main employee details for an [employeeID] from the backend.
  ///
  /// Return EmployeeDetails object decoded from the JSON response
  Future<EmployeeDetails> fetchEmployeeDetails(int employeeID) async {
    // TODO: Connect to backend
    var response = await rootBundle.loadString('assets/employeeDetails.json');
//    var response = await http.get('$endpoint/startPage', headers: headers);
    Map dataMap = jsonDecode(response);
    return EmployeeDetails.fromJson(dataMap);
  }

  /// Fetch time stamp for an certain [dateTime] from the
  /// backend. The backend returns a list of [TimeStampDay] from the current
  /// month, written in the specified date.
  ///
  /// Return a map of all [TimeStampDay] of the specified month.
  Future<Map<DateTime, List<TimeStampEvent>>> fetchTimeStampDaysForMonth(
      DateTime dateTime) async {
//    var response = await http.get(
//        '$endpoint/calendarData?date="${StringFormatter.getFormattedShortDateStringWithLines(DateTime(dateTime.year, dateTime.month, dateTime.day))}"',
//        headers: headers);
//    print(response.body);
//    print(StringFormatter.getFormattedShortDateStringWithLines(
//        DateTime(dateTime.year, dateTime.month, dateTime.day)));
    var response = await rootBundle.loadString('assets/calendar.json');
    Map<DateTime, List<TimeStampEvent>> dataMap = {};
    List<TimeStampDay> timeStampList = jsonDecode(response)
        .map<TimeStampDay>((json) => TimeStampDay.fromJson(json))
        .toList();
    timeStampList.forEach((timeStampDay) {
      dataMap[timeStampDay.date.subtract(Duration(hours: 1))] =
          timeStampDay.timeStampEvents;
    });
//    print('List ${timeStampList.length}');
//    print(dataMap.length);
    return dataMap;
  }

  /// Fetch time stamp applications for a certain [dateTime] from the
  /// backend. The backend returns a list of [TimeStampDay] from the current
  /// month, written in the specified date.
  ///
  /// Return a map of all [TimeStampDay] applications of the specified month.
  Future<List<TimeStampEvent>> fetchApplicationsForMonth(
      DateTime dateTime) async {
    var response = await rootBundle.loadString('assets/calendarFails.json');
    List<TimeStampEvent> timeStampList = jsonDecode(response)
        .map<TimeStampEvent>((json) => TimeStampEvent.fromJson(json))
        .toList();
    return timeStampList;
  }

  /// Post a time stamp for a [dateTime] and a certain [timeStampType] to the
  /// backend.
  ///
  /// Return the [timeStampResponse] of the backend.
  Future stamp(
      TimeStampEvent timeStampEvent, TimeStampType timeStampType) async {
    String body =
        '{"stampTime":"${timeStampEvent.dateTime.toUtc().toIso8601String()}", "timeStampType":"${StringFormatter.getEnumString(timeStampType)}"}';
    print(body);
    var response =
        await http.post('$endpoint/stamp', headers: headers, body: body);
    print(response.body);
    if (response.statusCode == 400) {
      throw Exception(TimeStampResponse.stampTypeFail);
    }
  }

  /// Post a time stamp for a [startDate], [endDate] and a certain [timeStampType] to the
  /// backend.
  Future stampAbsence(
      TimeStampType timeStampType, DateTime startDate, DateTime endDate) async {
    String body =
        '{"startDate":"${startDate.toUtc().toIso8601String()}","endDate":"${endDate.toUtc().toIso8601String()}","type":"${StringFormatter.getEnumString(timeStampType)}"}';
    print(body);
    var response =
        await http.post('$endpoint/applyAbsence', headers: headers, body: body);
    print(response.body);
    if (response.statusCode == 400) {
      throw Exception(TimeStampResponse.stampTypeFail);
    }
  }

  /// Logs the current user out.
  /// The sessionID on the backend server gets deleted.
  Future logOut() async {
    await http.get('$endpoint/logout', headers: headers);
  }
}
