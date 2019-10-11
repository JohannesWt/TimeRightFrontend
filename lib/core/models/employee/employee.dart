import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  Employee({
    this.employeeID,
    this.employeeLevel,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  final String employeeID;
  final EmployeeLevel employeeLevel;
}

enum EmployeeLevel {
  admin,
  executive,
  teamMember,
}
