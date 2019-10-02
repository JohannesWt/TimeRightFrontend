import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';

class Api {
  static const endpoint = 'https://www.webjump.pro/api/timetracking/';

  var client = new http.Client();

  /// Get detailed EmployeeProfile from employeeID
  Future<EmployeeDetails> getEmployeeProfile(String employeeID) async {
    var response = await client.get('$endpoint/employeeProfiles/$employeeID');

    return EmployeeDetails.fromJson(jsonDecode(response.body));
  }

  /// Get main Employee information from employeeID
  Future<Employee> getEmployee(String employeeID) async {
    var response = await rootBundle.loadString('assets/employee.json');
    print(response);
    // Delay
    await Future.delayed(Duration(seconds: 1));
    Map data = jsonDecode(response);
    return Employee.fromJson(data);
  }

  Future<EmployeeDetails> getEmployeeDetails(String employeeID) async {
    var response = await rootBundle.loadString('assets/employeeDetails.json');
    await Future.delayed(Duration(seconds: 2));
    print(response);
    Map data = jsonDecode(response);
    return EmployeeDetails.fromJson(data);
  }
}
