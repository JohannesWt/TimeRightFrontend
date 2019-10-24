/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

/// Holds the main information of an employee. This information gets fetched
/// first from the backend. By using the build_runner script this class
/// generates the employee.g.dart file automatically file which is used to
/// serialize the responded json data from the backend safely.
@JsonSerializable()
class Employee {
  Employee({
    this.employeeID,
    this.employeeLevel,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  final int employeeID;
  final EmployeeLevel employeeLevel;
}

enum EmployeeLevel {
  admin,
  executive,
  teamMember,
}
